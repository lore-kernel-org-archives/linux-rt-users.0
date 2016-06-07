From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: v3.18-RT
Date: Tue, 7 Jun 2016 10:36:41 +0200
Message-ID: <4061065f-dd2b-0a76-299e-ce66783d85dd@linutronix.de>
References: <FCC5AC80E299464B82E1345E2C10FC9D8098CE51@S1P5DAG4C.EXCHPROD.USA.NET>
 <20160603163732.GD4496@linutronix.de>
 <FCC5AC80E299464B82E1345E2C10FC9D8099ACF6@S1P5DAG4C.EXCHPROD.USA.NET>
 <16d5e3f2-dd20-c802-37aa-86eab553fcfc@linutronix.de>
 <FCC5AC80E299464B82E1345E2C10FC9D809A150B@S1P5DAG4C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: David Hauck <davidh@netacquire.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37503 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456AbcFGIgo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Jun 2016 04:36:44 -0400
In-Reply-To: <FCC5AC80E299464B82E1345E2C10FC9D809A150B@S1P5DAG4C.EXCHPROD.USA.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/06/2016 07:45 PM, David Hauck wrote:
> Hi Sebastian,

Hi,

> Thx, here's one - hope this might be helpful:
> 
> [    1.352165] BUG: unable to handle kernel 
> [    1.352167] paging request
> [    1.352169]  at a93c2560
> [    1.352172] IP:
> [    1.352178]  [<c107c248>] can_migrate_task+0x58/0x220
> [    1.352182] *pde = 00000000 

most of it should be one line.

this comes down to
  if (!cpumask_test_cpu(env->dst_cpu, tsk_cpus_allowed(p))) {

in can_migrate_task() and the crash happens because the pointer
returned in tsk_cpus_allowed() is invalid. Currently nothing rings a
bell.

> Great, thx, we'll get started on this this week.

okay.

> 
> Thanks again,
> -David

Sebastian
