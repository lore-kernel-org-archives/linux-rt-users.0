From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [ofa-general] [PATCH] [WORKAROUND] CONFIG_PREEMPT_RT and
	ib_umad_close() issue
Date: Mon, 17 Sep 2007 08:56:01 -0700
Message-ID: <adaps0hnv5a.fsf@cisco.com>
References: <46EE9BCC.1040301@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven-Thorsten Dietrich <sdietrich@novell.com>,
	linux-rt-users@vger.kernel.org, general@lists.openfabrics.org,
	linux-kernel@vger.kernel.org
To: John Blackwood <john.blackwood@ccur.com>
Return-path: <general-bounces@lists.openfabrics.org>
In-Reply-To: <46EE9BCC.1040301@ccur.com> (John Blackwood's message of "Mon,
	17 Sep 2007 11:22:52 -0400")
List-Unsubscribe: <http://lists.openfabrics.org/cgi-bin/mailman/listinfo/general>,
	<mailto:general-request@lists.openfabrics.org?subject=unsubscribe>
List-Archive: <http://lists.openfabrics.org/pipermail/general>
List-Post: <mailto:general@lists.openfabrics.org>
List-Help: <mailto:general-request@lists.openfabrics.org?subject=help>
List-Subscribe: <http://lists.openfabrics.org/cgi-bin/mailman/listinfo/general>,
	<mailto:general-request@lists.openfabrics.org?subject=subscribe>
Sender: general-bounces@lists.openfabrics.org
Errors-To: general-bounces@lists.openfabrics.org
List-Id: linux-rt-users.vger.kernel.org

 > When using OFED-1.2.5 based infiniband kernel modules on 2.6.22 based
 > kernels with the Ingo Molnar CONFIG_PREEMPT_RT applied, then commands
 > such as ibnetdiscvoer, smpquery, sminfo, etc. will hang.  The problem
 > is with the downgrade_write() rw semaphore usage in the
 > ib_umad_close() routine.

Can you give a few more details on how PREEMPT_RT changes locking
rules (or just exposes existing bugs maybe?) so that the
downgrade_write() causes the issue?  I would like to fix this cleanly
but I don't really understand what the problem is.

 - R.
