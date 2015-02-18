require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database

  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end

end


class User

  attr_accessor :id, :fname, :lname

  def initialize(id, fname, lname)
    @id = id
    @fname = fname
    @lname = lname
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?;
    SQL

    User.new(id, result[0]["fname"], result[0]["lname"])
  end

  def self.find_by_name(fname, lname)
    result = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?;
    SQL

    User.new(result[0]["id"], fname, lname)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    result = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        CAST((COUNT(ql.question_id)) AS FLOAT) / COUNT(DISTINCT(q.title)) karma
      FROM
        users
      JOIN
        questions AS q ON users.id = q.author_id
      LEFT OUTER JOIN
        question_likes AS ql ON q.id = ql.question_id
      WHERE
        users.id = ?;
    SQL
  end

  def save()
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        INSERT INTO
          users(fname, lname)
        VALUES
          (?, ?);
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, fname, lname, @id)
        UPDATE
          users
        SET
          fname = ?,
          lname = ?
        WHERE
          id = ?;
      SQL

    end
  end
end


class Question

  attr_accessor :id, :title, :body, :author_id

  def initialize(id, title, body, author_id)
    @id = id
    @title = title
    @body = body
    @author_id = author_id
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?;
    SQL

    Question.new(id, result[0]["title"], result[0]["body"],
                 result[0]["author_id"])
  end

  def self.find_by_author_id(author_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?;
    SQL

    result.map do |res|
      res = Question.new(res["id"], res["title"], res["body"], author_id)
    end
  end

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def author
    result = QuestionsDatabase.instance.execute(<<-SQL, @author_id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?;
    SQL

    User.new(@author_id, result[0]["fname"], result[0]["lname"])
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollower.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def save()
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, title, body, author_id)
        INSERT INTO
          questions(title, body, author_id)
        VALUES
          (?, ?, ?);
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, title, body, author_id, @id)
        UPDATE
          questions
        SET
          title = ?,
          body = ?,
          author_id = ?
        WHERE
          id = ?;
      SQL

    end
  end

end


class QuestionFollower

  attr_accessor :id, :user_id, :question_id

  def initialize(id, user_id, question_id)
    @id = id
    @user_id = user_id
    @question_id = question_id
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_followers
      WHERE
        id = ?;
    SQL

    QuestionFollower.new(id, result[0]["user_id"], result[0]["question_id"])
  end

  def self.followers_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_followers AS qf
      JOIN
        users ON qf.user_id = users.id
      WHERE
        qf.question_id = ?;
    SQL

    result.map do |res|
      res = User.new(res['id'], res['fname'], res['lname'])
    end
  end

  def self.followed_questions_for_user_id(user_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_followers AS qf
      JOIN
        questions ON qf.question_id = questions.id
      WHERE
        qf.user_id = ?;
    SQL

    result.map do |res|
      res = Question.new(res['id'], res['title'], res['body'], res['author_id'])
    end
  end

  def self.most_followed_questions(n)
    result = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        question_followers AS qf
      JOIN
        questions ON qf.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(questions.id) DESC
      LIMIT
        ? ;
    SQL

    result.map do |res|
      res = Question.new(res['id'], res['title'], res['body'], res['author_id'])
    end
  end


end


class Reply

  attr_accessor :id, :question_id, :parent_id, :author_id, :body

  def initialize(id, question_id, parent_id, author_id, body)
    @id = id
    @question_id = question_id
    @parent_id = parent_id
    @author_id = author_id
    @body = body
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?;
    SQL

    Reply.new(id, result[0]["question_id"], result[0]["parent_id"],
              result[0]["author_id"], result[0]["body"])
  end

  def self.find_by_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?;
    SQL

    result.map do |res|
      res = Reply.new(res["id"], question_id, res["parent_id"],
                      res["author_id"], res["body"])
    end
  end

  def self.find_by_user_id(user_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        author_id = ?;
    SQL

    result.map do |res|
      res = Reply.new(res["id"], res["question_id"], res["parent_id"], user_id, res['body'])
    end
  end

  def author
    result = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?;
    SQL

    User.new(author_id, result[0]['fname'], result[0]['lname'])
  end

  def question
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?;
    SQL

    Question.new(question_id, result[0]['title'], result[0]['body'], result[0]['author_id'])
  end

  def parent_reply
    result = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?;
    SQL
    return [] if result.empty?
    Reply.new(parent_id, result[0]['question_id'], result[0]['parent_id'], result[0]['author_id'], result[0]['body'])

  end

  def child_replies
    result = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL

    result.map do |res|
      res = Reply.new(res['id'], res['question_id'], id, res['author_id'], res['body'])
    end
  end

  # def save
  #   if @id.nil?
  #     QuestionsDatabase.instance.execute(<<-SQL, question_id, parent_id, author_id, body)
  #       INSERT INTO
  #         replies(question_id, parent_id, author_id, body)
  #       VALUES
  #         (?, ?, ?, ?);
  #     SQL
  #     @id = QuestionsDatabase.instance.last_insert_row_id
  #   else
  #     QuestionsDatabase.instance.execute(<<-SQL, question_id, parent_id, author_id, body, @id)
  #       UPDATE
  #         replies
  #       SET
  #         question_id = ?,
  #         parent_id = ?,
  #         author_id = ?,
  #         body = ?
  #       WHERE
  #         id = ?;
  #     SQL
  #
  #   end
  # end

  def save
    args = self.instance_variables.map{ |arg| arg[1..-1] }

    table = self.class.to_s.downcase

    table = (table == "reply") ? "replies" : (table + "s")

    f_args = []

    if @id.nil?
      non_id_args = args.drop(1)

      sql_string = "INSERT INTO #{table}(" + non_id_args.join(",") + ") VALUES ("

      (non_id_args.length - 1).times do
        sql_string << "?, "
      end

      sql_string << "?);"

      non_id_args.each do |arg|
       f_args << self.send(arg)
      end

      QuestionsDatabase.instance.execute(sql_string, *f_args)
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      non_id_args = args.drop(1)

      sql_string = "UPDATE #{table} SET " + non_id_args.join(" = ?, ") + " = ? WHERE id = ?;"

      (non_id_args + [args[0]]).each do |arg|
        f_args << self.send(arg)
      end

      QuestionsDatabase.instance.execute(sql_string, *f_args)
    end
  end

end




class QuestionLike

  attr_accessor :id, :user_id, :question_id

  def initialize(id, user_id, question_id)
    @id = id
    @user_id = user_id
    @question_id = question_id
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?;
    SQL

    QuestionLike.new(id, result[0]["user_id"], result[0]["question_id"])
  end

  def self.likers_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_likes AS ql
      JOIN
        users ON ql.user_id = users.id
      WHERE
        ql.question_id = ?;
    SQL

    result.map do |res|
      res = User.new(res['user_id'], res['fname'], res['lname'])
    end
  end

  def self.num_likes_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question_id = ?;
    SQL

    result[0]['COUNT(*)']
  end

  def self.liked_questions_for_user_id(user_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_likes AS ql
      JOIN
        questions ON ql.question_id = questions.id
      WHERE
        ql.user_id = ?;
    SQL

    result.map do |res|
      res = Question.new(res['question_id'], res['title'], res['body'], res['author_id'])
    end
  end

  def self.most_liked_questions(n)
    result = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        question_likes AS ql
      JOIN
        questions ON ql.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(questions.id) DESC
      LIMIT
        ? ;
    SQL

    result.map do |res|
      res = Question.new(res['question_id'],res['title'], res['body'], res['author'])
    end
  end

end
