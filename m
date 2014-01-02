From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH RT 0/2] migrate_disable pushdown in read/write_*lock*
Date: Thu, 2 Jan 2014 10:18:15 +0100
Message-ID: <20140102091815.GA1757@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi !

Background to the migration_disable pushdown in read_*lock* and write_*lock*

locks and managing migration:
 
  As long as access to an object is globally visible in a system we have pure 
 concurrency issues to handle. With growing physical system sizes and the 
 distributed nature of resources, problem partitioning becomes a necessity 
 to cope with complexity. Constraining the visibility of data objects to a 
 subset of computing resources on the other hand is not related to concurrent
 access - actually one can view topologically constraint objects like per_cpu
 as minimizing concurrency issues as the probability of local contention is 
 simply smaller than of global contention. Migration with held locks on 
 globally referenced objects is perfectly fine so in this sense it also 
 makes little sense for concurrency management primitives in general 
 to disable migration.

  Currently though the locks do not differenciate between topologically
 constraint access since migrate_disable/enable is still RT specific even 
 though non-RT would also benefit by reduced contention. To make the 
 locks that become preemptible in -rt safe for possible use with per_cpu
 objects they must ensure referencial consistency during preemption and 
 therefor all of the preemptible rt locks must migrate_disable. The question
 is where must/can the migrate_disable be placed ?

  The problem of locking and migration is actually orthogonal and needs 
 independent treatment - and maybe more important - independent consideration
 during design of code. 

  To show in what way they are orthogonal lets consider a concurrent access
 to a localized data object:

  1 case)

                access
       |     |  per_cpu  |    |
     lock   pin        unpin unlock

  would be safe - the properties required are
   * references are valid (by pinning)
   * access is consistent/exclusive (by locking)
  a concurrent access is blocked by the lock and once any thread acquired the 
  lock it would enter the migrate disable section exclusively - so both
  properties hold.

 2 case)

                access 
       |     |  per_cpu  |    |
      pin  lock       unlock unpin
   
  would also be safe - 
   * access is consistent/exclusive 
   * references are valid
  as the task is pinned during the exclusive (lock protected) access the 
  data is guaranteed to be consistent.
  3 case)
             
               access 
      |     |  per_cpu  |    |
     lock  pin       unlock unpin

  still safe ! though strange. access between pin and unlock provides both 
  required properties. A concurrent access would pin the task and block in the 
  lock, after the first task releases the lock the unblocked task would get
  consistent access until it unpins which is longer than the time the lock
  is held - so again consistent and exclusive. 
  
  4 case)  
             
               access 
      |     |  per_cpu  |    |
     pin  lock        unpin unlock

  safe (and strange) as well !  
 
  so locking and migration protection are orthogonal as claimed.
  That said - it may not make sense to allow every combination for 
  readability - just like it is convention to unlock locks in reverse 
  order from taking them even though technically unlocking may happen in any 
  (random) order without jeopardizing the lock correctness.

 Further there were concerns that there might be some situations where the
migrate_disable in the upper API layers would be necessary to ensure 
correctness of the call chain. My assumption here is that this only could
be the case if the call tree of the read/write_*lock* would be accessing some 
per_cpu object after the original point of migrate_disable and the pushed down
point of migrate_disable. As the call path analysis showed there are no
per_cpu objects in use between the old and new location so the pushdown
should be as safe as it was before.

Link: http://www.spinics.net/lists/linux-rt-users/msg10897.html
