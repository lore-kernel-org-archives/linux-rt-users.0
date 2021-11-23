Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858A1C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Nov 2021 08:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhKWI2P (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 03:28:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36696 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhKWI2M (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Nov 2021 03:28:12 -0500
Date:   Tue, 23 Nov 2021 09:25:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637655901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vpJGbWyXU7hf/Jef5YCyYb2BZvB+8lPOPuulIvAEgVo=;
        b=SmiY4RQnHjCZigM6qXi0Cl4cSB7llw2Nf9slLFIWd5VoiwXGG4JWZQD5GpbQAV46+AiCOo
        iNuQo7ZE+x5yON0MzHdkrpsg93aaMFq0kWztu522q/lQIhQ7Ip7Q9EXt+2TaYKc7yN1fD2
        2oO9BEqDwfeTLuP3OEyqaoJjPVShLOlGOv4g3B9g7OJ/Hzi2hBiXcgXdoIQI4kB8+SHYqR
        Wu8oolWBVkQmR0WCYHDKYp6BsQTupCM6+ruGfDMaVnc5EN5Gg2Pl8+weLMKUWxIO6QqGPh
        e+riVOhMNDLX3Z5yy8CwzM973kO/GdmwcUaIE0ZpMagjhvi6S+89B9ib3HTF1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637655901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vpJGbWyXU7hf/Jef5YCyYb2BZvB+8lPOPuulIvAEgVo=;
        b=v95tJC1CZqA5VFmkFT/q7kvNfUeZeEHHj4I+qpbv8U6+f3oDm6+iPr3Ui06jVkd7Qw44R6
        Wk6yTEPWqb8b2CAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Clark Williams <williams@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH RT 09/10] drm/i915/gt: Queue and wait for the irq_work
 item.
Message-ID: <20211123082500.hprw3gmjzrd3i4ib@linutronix.de>
References: <20211122203847.390551309@goodmis.org>
 <20211122203905.001687595@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211122203905.001687595@goodmis.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-22 15:38:56 [-0500], Steven Rostedt wrote:
> 5.10.78-rt56-rc2 stable review patch.
> If anyone has any objections, please let me know.

I don't mind releasing this as it is but could you please add the
following irq-work patches:

* 09089db79859c irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT
* b4c6f86ec2f64 irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT
* 810979682ccc9 irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ support.

in a follow-up release?

Sebastian
