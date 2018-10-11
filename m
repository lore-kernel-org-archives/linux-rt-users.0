Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:44178 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728239AbeJLCaQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Oct 2018 22:30:16 -0400
From: Julia Cartwright <julia@ni.com>
Subject: Re: freezing system
Date: Thu, 11 Oct 2018 19:01:35 +0000
Message-ID: <20181011190133.GF21426@jcartwri.amer.corp.natinst.com>
References: <53E9713C-8920-41A7-A9D6-4E5169C77CF2@ableton.com>
In-Reply-To: <53E9713C-8920-41A7-A9D6-4E5169C77CF2@ableton.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68D45A403F9A824E9B35E4CE02DBFF42@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Diez Roggisch <diez.roggisch@ableton.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>

Hello Diez-

On Thu, Oct 11, 2018 at 04:30:36PM +0000, Diez Roggisch wrote:
> Hi,
>
> during work on a driver I encountered a behaviour I can't explain and
> would like to hear the opinion of the experts here.
>
> We work with the rasperry PI 3 (in it's compute module incarnation,
> but that shouldn't make a difference for this discussion).
>
> It is hooked up to a microcontroller via SPI, and because the uC needs
> to signal that it is ready to receive data, we strung an IRQ line to a
> GPIO on the pi.
>
> In the driver I register an ISR for that GPIO which signals a
> wait_queue_head_t with wake_up. The ISR is allocated with
> IRQF_NO_THREAD because this is on our critical path and should be as
> fast as possible.

Can you reproduce the hanging behaviour without IRQF_NO_THREAD?

In general, the signalling/wakeup of wait queues is not allowed from
hardirq context (like what would happen if you've passed IRQF_NO_THREAD
at the time you register your handler).  If there's ever contention on
the waitqueue's internal spin_lock on RT, the handler will end up trying
to schedule() in a non-schedulable context.  This might lead to a
complete hang like you're seeing.

Good luck,
   Julia
