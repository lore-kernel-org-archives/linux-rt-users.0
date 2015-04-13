From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] hwlat_detector: Detect hardware-induced latencies
Date: Mon, 13 Apr 2015 10:31:30 +0200
Message-ID: <552B7EE2.1090005@monom.org>
References: <1428508021-28166-1-git-send-email-daniel.wagner@bmw-carit.de>	<20150408123550.7dbd61b4@gandalf.local.home>	<5526458E.5050202@bmw-carit.de>	<552682A4.4000309@osadl.org> <20150409101037.4dd0837a@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>,
	linux-rt-users@vger.kernel.org, Jon Masters <jcm@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Tom Zanussi <tom.zanussi@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35334 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbbDMIbe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Apr 2015 04:31:34 -0400
Received: by widdi4 with SMTP id di4so62719947wid.0
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Apr 2015 01:31:33 -0700 (PDT)
In-Reply-To: <20150409101037.4dd0837a@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On 04/09/2015 04:10 PM, Steven Rostedt wrote:
> On Thu, 09 Apr 2015 15:46:12 +0200
> Carsten Emde <C.Emde@osadl.org> wrote:
> 
>> Hi Daniel,
>>
>>> BTW, are you also taking care of the latency-hist.patch patch?
>> I do.
>>
>> However, the request (and the challenge) is not to simply rewrite the 
>> code. The idea is to provide a general histogram framework that can be 
>> used from anywhere in the kernel and to equip it with everything needed 
>> by the existing histograms. This framework should no longer be part of 
>> the RT patches but submitted directly to mainline Linux. In a second 
>> step, we will then rewrite the existing histogram code to use the new 
>> framework.
>>
>> Any help is greatly appreciated!

I'll start poking around then :)

> Hmm, Currently Tom Zanussi is working on a hist trigger for tracing.
> Not sure it can be used here, but perhaps ideas can be spawned.
> 
> http://marc.info/?l=linux-kernel&m=142807630917288

>From a quick look, it should be possible to add on top of those patches
the two TRACE_EVENTs (preemptirqsoff_hist, hrtimer_interrupt), annotate
start_critical_*() & and friends (from latency-hist.patch). I'll try
that and see what explodes.

cheers,
daniel
