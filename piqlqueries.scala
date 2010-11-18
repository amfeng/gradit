package edu.berkeley.cs.scads.piql

import edu.berkeley.cs.scads.storage._
import edu.berkeley.cs.avro.marker._

import org.apache.avro.util._

case class Word(var word: String) extends AvroPair {
  var definition: String = _
  var wordlist: WordList = _
}

case class WordList(var name: String) extends AvroPair{
}

case class Book(var title: String) extends AvroPair

case class Context(var contextId: Int) extends AvroPair {
  var word: Word = _
  var book: Book = _
  var wordLine: String = _
  var before: String = _
  var after: String = _
}

class GraditClient(val cluster: ScadsCluster, executor: QueryExecutor) {
  val maxResultsPerPage = 10

  // namespaces are declared to be lazy so as to allow for manual
  // createNamespace calls to happen first (and after instantiating this
  // class)

  lazy val words = cluster.getNamespace[Word]("words")
  lazy val thoughts = cluster.getNamespace[Book]("books")
  lazy val context  = cluster.getNamespace[Context]("contexts")
  lazy val wordlists  = cluster.getNamespace[WordList]("wordlists")

  private def exec(plan: QueryPlan, args: Any*) = {
    val iterator = executor(plan, args:_*)
    iterator.open
    val ret = iterator.toList
    iterator.close
    ret
  }

  //contextsForWord

  //wordsFromWordlist

  
  /*def findUser = users.where("username".a === (0.?))

  def thoughtstream = (
    subscriptions
      .where("owner".a === (0.?))
      .where("approved".a === true)
      .join(thoughts)
      .where("thoughts.owner".a === "subscriptions.target".a)
      .sort("timestamp" :: Nil, false)
      .limit(10)
  )*/

}
