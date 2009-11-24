From: "Leyendecker, Robert" <Robert.Leyendecker@lsi.com>
Subject: RE: help needed, 2.6.31.6-rt19 hang with network user app
Date: Tue, 24 Nov 2009 10:47:03 -0500
Message-ID: <8C8865ED624BB94F8FE50259E2B5C5B304593DAB2E@palmail03.lsi.com>
References: <8C8865ED624BB94F8FE50259E2B5C5B304593DAA9E@palmail03.lsi.com>
 <200911210044.09962@blacky.localdomain>
 <8C8865ED624BB94F8FE50259E2B5C5B304593DAACF@palmail03.lsi.com>
 <200911211125.38161@blacky.localdomain>
 <8C8865ED624BB94F8FE50259E2B5C5B304593DAAD2@palmail03.lsi.com>
 <8C8865ED624BB94F8FE50259E2B5C5B304593DAAED@palmail03.lsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:59074 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758080AbZKXPrH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Nov 2009 10:47:07 -0500
Received: from milmhbs0.lsil.com (mhbs.lsil.com [147.145.1.30])
	by mail0.lsil.com (8.12.11/8.12.11) with ESMTP id nAOFl5A5029611
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Nov 2009 07:47:05 -0800 (PST)
Received: from PALHUB01.lsi.com (palhub01.lsi.com [128.94.213.114])
	by milmhbs0.lsil.com (8.12.11/8.12.11) with ESMTP id nAOFl76G029234
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Nov 2009 07:47:08 -0800
In-Reply-To: <8C8865ED624BB94F8FE50259E2B5C5B304593DAAED@palmail03.lsi.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> > >
> > > > Nov 20 21:12:00 localhost kernel: BUG: using smp_processor_id()
> in
> > > preemptible [00000000] code: smash/6801
> > > > Nov 20 21:12:00 localhost kernel: caller is  __schedule+0xe/0x7d4
> > Nov
> > > 20 21:12:00 localhost kernel: Pid: 6801, comm: smash Not tainted
> > > 2.6.31.6-rt19 #1
> > > > Nov 20 21:12:00 localhost kernel: Call Trace:
> > > > Nov 20 21:12:00 localhost kernel: [<c06dc3df>] ? printk+0xf/0x18
> > > > Nov 20 21:12:00 localhost kernel: [<c05499a6>]
> > > debug_smp_processor_id+0xa6/0xbc
> > > > Nov 20 21:12:00 localhost kernel: [<c06dc689>]
> __schedule+0xe/0x7d4
> > > > Nov 20 21:12:00 localhost kernel: [<c046621f>] ?
> > > audit_syscall_exit+0xfa/0x10f
> > > > Nov 20 21:12:00 localhost kernel: [<c040a955>] ?
> > > syscall_trace_leave+0xc8/0xef
> > > > Nov 20 21:12:00 localhost kernel: [<c040338a>]
> > work_resched+0x5/0x19
> > >
> > > Hopely somebody on list will be able to comment on this.
> >
> 

Re-posted to LKML http://lkml.org/lkml/2009/11/23/548 and opened a bug in Fedora Bugzilla 540961.
