Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D795C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Nov 2021 10:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351858AbhKYKHh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 25 Nov 2021 05:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351983AbhKYKFh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Nov 2021 05:05:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C7C061761;
        Thu, 25 Nov 2021 02:01:15 -0800 (PST)
Date:   Thu, 25 Nov 2021 11:01:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637834470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/skebmZxsux8Zxu5ubjRclpcdMkr1XyC5hOUdawn5E=;
        b=xGDbKqeSxYOoIbyA0MaiJW9PM+zfzOUk5n0UOWrZ/IzvUE24J04lGLxDntYRLAWVga0Lmn
        gs9MauF8SoyQ8HAwOq2gtGeeVJCxEtwjI0lDblko9En7SESM12xTG+ipmsWeaajl/rLooc
        n4HIXpWqU7vNMdYVICpmUeTmsZ3rMsLp4tkoNHZ+2QZbILmiQIHwAMPg15LFekN6WiiR5C
        2YXzHrh2hc6aO4LEZfaG0hw7BIojz75F1PjR6RD4uTUTnRGGTKrB9GsO7QJffGdCO+G0ec
        avRZ2T0Y0yn3/0Bow7hApbzxh5jMAFx3WyF+mZw9DTf6mCO6RpGabPGodvfJXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637834470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/skebmZxsux8Zxu5ubjRclpcdMkr1XyC5hOUdawn5E=;
        b=a3BEDJ2t7chO5QKabuexPWl9DuuE0qyfe2Xqeq+NqKl0L4UcOeW0+T/g63B8+7uzWFa0qR
        9mLy4fs4xsT7gBCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Luis Goncalves <lgoncalv@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        stable-rt@vger.kernel.org, Nitesh Narayan Lal <nilal@redhat.com>,
        Pei Zhang <pezhang@redhat.com>
Subject: Re: [RFC RT v5.10] [rt] repair usage of dev_base_lock in
 netstat_show()
Message-ID: <20211125100109.qxc6k4a46s6ndv4e@linutronix.de>
References: <YVuviZ3F7MbPvleo@uudg.org>
 <20211011135609.22y7hkycbqm52w6d@linutronix.de>
 <20211011163601.m6j3ibb7ydeevpiz@linutronix.de>
 <CAD8J--8CjZym2afG3iSdztz51nOt9gmy747KPDxdmr1_WzwxcA@mail.gmail.com>
 <CAD8J---uJXqKeYR_3_8O5WPr9pVH8HX1DmGfE+7MdHDmaK4-Mw@mail.gmail.com>
 <CAD8J---a6X1u7SvKs5mR=EzxJ1uUxYZ0OGqM3PPq_LowBgY-Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD8J---a6X1u7SvKs5mR=EzxJ1uUxYZ0OGqM3PPq_LowBgY-Gw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-24 22:39:34 [-0300], Luis Goncalves wrote:
> Sebastian, I just stumbled over the lockdep splat being discussed here
> in v5.15.3-rt21. Well, slightly different, but related to the very
> same situation:
=E2=80=A6

so we have write_lock_bh(&dev_base_lock) and read_lock(&dev_base_lock)
followed by local_bh_disable() (due to spin_lock_bh(&adap->mbox_lock)).

It makes sense to only change that one invocation. Let me form a patch.

Sebastian
