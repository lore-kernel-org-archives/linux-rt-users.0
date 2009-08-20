From: john stultz <johnstul@us.ibm.com>
Subject: Re: [ANNOUNCE] 2.6.31-rc6-rt5
Date: Wed, 19 Aug 2009 19:19:02 -0700
Message-ID: <1f1b08da0908191919x77c8e9edu9f31a9a56ba41ee@mail.gmail.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0906121800590.3369@localhost.localdomain>
	 <alpine.LFD.2.00.0906151117440.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906170903370.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906231418500.2767@localhost.localdomain>
	 <alpine.LFD.2.00.0907092020410.2768@localhost.localdomain>
	 <alpine.LFD.2.00.0907300006250.2936@localhost.localdomain>
	 <alpine.LFD.2.00.0908162207370.2782@localhost.localdomain>
	 <alpine.LFD.2.00.0908182140340.3361@localhost.localdomain>
	 <alpine.LFD.2.00.0908192344500.3361@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>, Jan Blunck <jblunck@suse.de>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>,
	Dinakar Guniguntala <dino@in.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:64141 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbZHTCTE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Aug 2009 22:19:04 -0400
In-Reply-To: <alpine.LFD.2.00.0908192344500.3361@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Aug 19, 2009 at 2:48 PM, Thomas Gleixner<tglx@linutronix.de> wrote:
> We are pleased to announce the next update to our new preempt-rt
> series.

Hey Thomas, Peter, Ingo,
    I'm still seeing the odd SMP scheduler behavior (where all the
processes line up on a single cpu) with -rt5. This can be easily
reproduced with a "make -j8 bzImage".  I'm I the only one seeing this?
 Any suggestions on further debugging this?

thanks
-john
