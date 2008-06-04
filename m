From: "Rune Torgersen" <runet@innovsys.com>
Subject: RE: [PATCH 2/2] sched: fix cpupri priocount
Date: Wed, 4 Jun 2008 16:35:28 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B047FE4EA@ismail.innsys.innovsys.com>
References: <20080604185838.5108.54912.stgit@novell1.haskins.net> <20080604190410.5108.78092.stgit@novell1.haskins.net> <1212613754.19205.25.camel@lappy.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutonix.de>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Arnaldo Carvalho de Melo" <acme@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: "Peter Zijlstra" <peterz@infradead.org>,
	"Gregory Haskins" <ghaskins@novell.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759872AbYFDVdq@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <1212613754.19205.25.camel@lappy.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> > -#define CPUPRI_NR_PRI_WORDS CPUPRI_NR_PRIORITIES/BITS_PER_LONG
> > +#define CPUPRI_NR_PRI_WORDS (CPUPRI_NR_PRIORITIES + >
BITS_PER_LONG/2)/BITS_PER_LONG
> 
> (33 + 16) / 32 = 49 / 32 = 1
> 

It should not round to neares but round up....
So... #define CPUPRI_NR_PRI_WORDS (CPUPRI_NR_PRIORITIES + BITS_PER_LONG
- 1)/BITS_PER_LONG

=> (33+31)/32 = 64/32 = 2
