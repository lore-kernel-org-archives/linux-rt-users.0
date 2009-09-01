From: Roland Dreier <rdreier@cisco.com>
Subject: Re: RFC: THE OFFLINE SCHEDULER
Date: Tue, 01 Sep 2009 09:15:46 -0700
Message-ID: <adaskf6od3h.fsf@cisco.com>
References: <1251282598.3514.20.camel@raz>
	<alpine.DEB.1.10.0908260943090.9924@gentwo.org>
	<1251297910.1791.22.camel@maxim-laptop> <1251322663.3882.48.camel@raz>
	<4A96B997.1070001@nortel.com>
	<alpine.DEB.1.10.0908271257270.17470@gentwo.org>
	<alpine.LFD.2.00.0908272242500.2888@localhost.localdomain>
	<4A97071F.5070804@novell.com> <4A973DAE.4020508@redhat.com>
	<4A975025.8030500@novell.com> <4A975CC4.1090208@novell.com>
	<alpine.LFD.2.00.0908281218560.2888@localhost.localdomain>
	<alpine.DEB.1.10.0908281446520.7317@gentwo.org>
	<alpine.LFD.2.00.0908282100040.19335@localhost.localdomain>
	<alpine.DEB.1.10.0908281551450.17784@gentwo.org>
	<alpine.LFD.2.00.0908282158100.19335@localhost.localdomain>
	<alpine.DEB.1.10.0908281619520.15573@gentwo.org>
	<alpine.LFD.2.00.0908282231260.19335@localhost.localdomain>
	<alpine.DEB.1.10.0908311517410.26046@V090114053VZO-1>
	<adavdk3q3nk.fsf@cisco.com>
	<alpine.DEB.1.10.0909011440210.12112@V090114053VZO-1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>,
	Rik van Riel <riel@redhat.com>,
	Chris Friesen <cfriesen@nortel.com>,
	raz ben yehuda <raziebe@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu,
	peterz@infradead.org, maximlevitsky@gmail.com, efault@gmx.de,
	wiseman@macs.biu.ac.il, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Christoph Lameter <cl@linux-foundation.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755075AbZIAQPq@vger.kernel.org>
In-Reply-To: <alpine.DEB.1.10.0909011440210.12112@V090114053VZO-1> (Christoph
	Lameter's message of "Tue, 1 Sep 2009 14:42:29 -0400 (EDT)")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


 > Ok then these per cpu irqs are there to support something different? There
 > are per cpu irqs here. Seems to be hardware supported?

Yes, the driver now creates per-cpu IRQs for completions.  However if
you don't trigger any completion events then you won't get any
interrupts.  That's different from the workqueues, which are used to
poll the hardware for port changes and internal errors (and which are
single-threaded and can be put on whatever "system services" CPU you want)

 - R.
