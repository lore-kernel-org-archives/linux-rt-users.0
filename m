Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873C5C432BE
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Aug 2021 11:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6571B63244
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Aug 2021 11:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhHPL6q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Aug 2021 07:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhHPL6o (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Aug 2021 07:58:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A138C061764
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Aug 2021 04:58:13 -0700 (PDT)
Date:   Mon, 16 Aug 2021 13:58:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629115091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fjzdMSXkGh46y0XozvtxPI5YW+q0PCNlyGHyMuGwP7k=;
        b=RX7bTusX87e25y4nmhL1nVGM/nabUZu+vN9vdSwcsf5S02GhlIKw1YTsNviI4lWdE4Quzl
        kayEr3vQLZznqCXHes8IHUIhZ8gEkblKg4Db8EP36sAI7twYyMU7ahyBQsnJPIvIIt8OQ0
        YAo3oM1iK0Y1SAq6e6j8srqDvmUr855TmQwAyC5QTsHOiOk4V54OO90y1WUspwHGoxusyW
        CSeF1VQiiqpNE/vdY4lB84OQu+PtAMlxsaAMqAALGmBquMfnfUJMlMfLLD0mGIN07o6B/b
        yn+0YQbfzDq+t95p5YGfxxu5XiXVhkU8UvF9Uln5robAWUMEX/Zx4LqQt06suQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629115091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fjzdMSXkGh46y0XozvtxPI5YW+q0PCNlyGHyMuGwP7k=;
        b=I2wW+HLnXytH0DPoU3+ui/7nir4gzB8Gd8PC9/1HCxIOQ2CnH++T3TOVRXxQMTDEFL2FM0
        Mm7MYQ4KmzkKx3AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [rteval] Fails to work without numactl
Message-ID: <20210816115809.bb4jtb56zkagqmq6@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rteval as of v3.2 (and the main branch) fails to work continue without
numactl around:

| [DEBUG] [kcompile] systopology: 1 node system (8 cores per node)
| [DEBUG] [kcompile] Configuring build job for node 0
| Exception in thread kcompile:
| Traceback (most recent call last):
|   File "/usr/lib/python3.9/threading.py", line 954, in _bootstrap_inner
|     self.run()
|   File "/home/bigeasy/rteval/rteval/modules/__init__.py", line 181, in run
|     self._WorkloadSetup()
|   File "/home/bigeasy/rteval/rteval/modules/loads/kcompile.py", line 206,=
 in _WorkloadSetup
|     self.buildjobs[n] =3D KBuildJob(self.topology[n], self.mydir, \
|   File "/home/bigeasy/rteval/rteval/modules/loads/kcompile.py", line 55, =
in __init__
|     self.binder =3D 'taskset -c %s' % compress_cpulist(cpulist)
|   File "/home/bigeasy/rteval/rteval/misc.py", line 62, in compress_cpulist
|     if isinstance(cpulist[0], int):
| TypeError: 'NoneType' object is not subscriptable

It continues to wait for kcompile=E2=80=A6

With numactl around it uses a different path and continues. However it
then finishes (the main binary) while the compile job and hackbench
continues (not sure if this is intended).

Sebastian
