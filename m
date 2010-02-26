From: Dan Carpenter <error27@gmail.com>
Subject: Re: [ANNOUNCE] 2.6.33-rc8-rt2
Date: Fri, 26 Feb 2010 22:44:36 +0300
Message-ID: <20100226194436.GE8417@bicker>
References: <alpine.LFD.2.00.1002241740410.4245@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <williams@redhat.com>, nando@ccrma.Stanford.EDU,
	Carsten Emde <ce@ceag.ch>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43020 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965843Ab0BZTou (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2010 14:44:50 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002241740410.4245@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

kernel/trace/latency_hist.c
   341  static ssize_t
   342  latency_hist_reset(struct file *file, const char __user *a,
   343                     size_t size, loff_t *off)
   344  {
   345          int cpu;
   346          struct hist_data *hist = NULL;
   347  #if defined(CONFIG_WAKEUP_LATENCY_HIST) || \
   348      defined(CONFIG_MISSED_TIMER_OFFSETS_HIST)
   349          struct maxlatproc_data *mp = NULL;
   350  #endif
   351          off_t latency_type = (off_t) file->private_data;
   352  
   353          for_each_online_cpu(cpu) {
   354  
   355                  switch (latency_type) {

It seems like this switch statement should have a default case.

I haven't looked into it very closely but it seems like if you had all 
those config options turned off then "hist" would be still be NULL.

regards,
dan carpenter


