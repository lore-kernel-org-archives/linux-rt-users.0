From: Gregory Haskins <ghaskins@novell.com>
Subject: [RT PATCH v3 0/2] Fix for "[BUG][PPC64] BUG in 2.6.26.5-rt9 causing
	Hang"
Date: Mon, 06 Oct 2008 11:14:32 -0400
Message-ID: <20081006151228.8452.69938.stgit@dev.haskins.net>
References: <20080925123235.GA27916@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, dvhltc@us.ibm.com, dino@in.ibm.com,
	Gilles.Carry@bull.net
To: Chirag Jog <chirag@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754815AbYJFPKX@vger.kernel.org>
In-Reply-To: <20080925123235.GA27916@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steve,
  Chirag reported (via IRC) that v2 fixed his issue.  V3 is identical to v2
  except I cleaned up the patch description and fixed a comment typo.  This
  applies to 26.5-rt9.  Please consider it an urgent fix for -rt10.

Regards,
-Greg

---

Gregory Haskins (2):
      RT: fix push_rt_task() to handle dequeue_pushable properly
      RT: Remove comment that is no longer true


 kernel/sched_rt.c |   44 ++++++++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 22 deletions(-)

-- 
