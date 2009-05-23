From: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: Real-Time & Determinism
Date: Sat, 23 May 2009 15:09:29 +0200
Message-ID: <c384c5ea0905230609q5cce9b01ya2004b312b98b1e1@mail.gmail.com>
References: <4A17F444.6070005@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Antoine Nourry <nourry@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:56177 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZEWNJ2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 May 2009 09:09:28 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1333697ywb.1
        for <linux-rt-users@vger.kernel.org>; Sat, 23 May 2009 06:09:29 -0700 (PDT)
In-Reply-To: <4A17F444.6070005@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Sat, May 23, 2009 at 3:04 PM, Antoine Nourry <nourry@free.fr> wrote:
> why can we read everywhere that Preempt_RT offers hard real time
> capabilities while on another hand we can find in some papers that it is not
> deterministic and only gives assurance to obtain low latencies ? is it real
>
Can you give some links of one and the other?

> time or not (deterministic) ? if yes, is it hard or soft RT ? Please excuse
> me if i've missed something important.
>

This is a simplistic summary as I learned it:

It's hard real-time behaviour.

However, as the kernel consist of a large amount of code, every piece
of code must behave properly with regard to locking etc. so that the
real-time scheduler is actually able to pre-empt with low latency
intervals.

The tracing code has been included to find those long no-pre-empt
spots in the kernel code.

Regards,
-- 
Leon
