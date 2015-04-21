From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [GIT RFC PULL rcu/urgent] Prevent Kconfig from asking pointless
 questions
Date: Tue, 21 Apr 2015 05:37:12 +0200
Message-ID: <1429587432.3158.24.camel@gmail.com>
References: <20150416183812.GA5571@linux.vnet.ibm.com>
	 <20150418130340.GA26931@gmail.com>
	 <20150418133444.GD23685@linux.vnet.ibm.com>
	 <20150418143238.GA2337@gmail.com>
	 <20150419020541.GA5561@linux.vnet.ibm.com> <20150420113554.598e503f@sluggy>
	 <20150420170902.GU5561@linux.vnet.ibm.com>
	 <20150420180107.GE24936@home.goodmis.org>
	 <20150420180904.GA19229@gmail.com>
	 <20150420142149.3ac58a2c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	a.p.zijlstra@chello.nl, akpm@linux-foundation.org,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36442 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbbDUDh1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Apr 2015 23:37:27 -0400
In-Reply-To: <20150420142149.3ac58a2c@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2015-04-20 at 14:21 -0400, Steven Rostedt wrote:
> 
> I would argue than every case is different, and only the sysadmin 
> would
> know the right value. Thus, just set it to one, and if that's not 
> good
> enough, then the sysadmins can change it to their needs.

Agreed.  I don't have it turned on in my -rt kernels, because I don't 
want to force a knight in shining (priority x) armor on users.

        -Mike

