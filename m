From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC][PATCH RT 0/3] RT: Fix trylock deadlock without msleep()
 hack
Date: Mon, 7 Sep 2015 12:10:17 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509071209200.15006@nanos>
References: <20150904011900.730816481@goodmis.org> <alpine.DEB.2.11.1509051217330.15006@nanos> <20150905120457.GA21338@gmail.com> <alpine.DEB.2.11.1509070959440.15006@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38189 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbbIGKK6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 Sep 2015 06:10:58 -0400
In-Reply-To: <alpine.DEB.2.11.1509070959440.15006@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 7 Sep 2015, Thomas Gleixner wrote:
> 1) The boosting is not related to anything.
> 
>    If the priority of taskB changes then nothing changes the boosting
>    of taskA.
> 
> 2) The boosting stops

Scratch that #2. Hit send too fast. #1 and #3 still hold.
 
Thanks,

	tglx
