From: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: [SLAB] Disabling cache_reap when running PREEMPT_RT
Date: Tue, 9 Nov 2010 10:48:03 +0100
Message-ID: <AANLkTikYf_v=oZw2EoLJRsU-LW_swPLoQwOPfvxqi6Nz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33758 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab0KIJsF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Nov 2010 04:48:05 -0500
Received: by wyb36 with SMTP id 36so4613711wyb.19
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Nov 2010 01:48:04 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi everybody,

I have seen some latencies during my tests on a MPC5200 board, and
when I remove cache_reap I can see (really) less missed deadlines (in
my use case).
Without taking this as a requirement, I would like to know if there is
a way to be free of this call ?
Having priorities on my IRQs and Softirqs is not sufficient.

AFAIK, SLUB is not working with PREEMT_RT, so I have to focus on SLAB
(and SLOB introduces lots of missed deadlines).

If you have any idea of the root cause, I am looking forward to it :).
BR,
JM
