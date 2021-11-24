Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EE1C43219
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Nov 2021 16:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348026AbhKXQPo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 11:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhKXQPm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Nov 2021 11:15:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF9FC061746;
        Wed, 24 Nov 2021 08:12:32 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637770349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V+peSXz08GsQ8hQqxg4MLbOHFdMUhs3OGWXG8JXJBIw=;
        b=ovaBNK9j3Z3udpAcDw8HFOhWX1o4ee8YoUkLzdhAQa1eKUyvk8H+yLgfb1PbUpOZcBO30+
        9eEQ1Ycy5cbTfdn+WSoBRBRTVznb78M5iCTAeU0oEUSffJMl9t35U4E8lBip6htEi6T81r
        D5uW/LIoVa8CCuWU7uZm5O5kd4V4Qh5cQ8SD19K2D1Ea+LR2ztJmQbc2qwqsD7vq7leCW3
        fo+l/WuhiA2mV67+JqHh06GXN5TQkfaFSAXfxUgiaci7GajrLaKANV2HKxGpPybD0+ygGO
        ktb8rJID07e7jnoywgMapt7cO4f0luBTQOMEZzQNR3c+vE+3QoWUAT5fVA92eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637770349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V+peSXz08GsQ8hQqxg4MLbOHFdMUhs3OGWXG8JXJBIw=;
        b=fBj6wR4/p873SH7+mQx9Owx0s748fBtU+1BdKtWXzJOA4E0C2CsDhpwyabZLim/DAdSSON
        qoPclu7+lDOCFqCQ==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Clark Williams <williams@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        bigeasy@linutronix.de
Subject: Re: [PATCH RT 09/10] drm/i915/gt: Queue and wait for the irq_work item.
Date:   Wed, 24 Nov 2021 17:12:18 +0100
Message-Id: <20211124161221.2224005-1-bigeasy@linutronix.de>
In-Reply-To: <20211123103755.12d4b776@gandalf.local.home>
References: <20211123103755.12d4b776@gandalf.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-23 10:37:55 [-0500], Steven Rostedt wrote:
> Is there something else missing here, as this gives the following rejects=
 in
> irq_work.c:

Yeah, there is this irq-work in v5.10-RT and this slightly different
thing that managed upstream while upstream managed to alter their code,
too  :)

Please find attached as a reply to this email the backported patches:
   [PATCH RT 1/3] irq_work: Allow irq_work_sync() to sleep if irq_work() no
   [PATCH RT 2/3] irq_work: Handle some irq_work in a per-CPU thread on
   [PATCH RT 3/3] irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on

which apply here on top of v5.10.78-rt55.

Sebastian

