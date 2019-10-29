Return-Path: <SRS0=+wl0=YW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F5ACA9EC3
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Oct 2019 19:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B552086A
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Oct 2019 19:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sv+f8w1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfJ2Ted (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Oct 2019 15:34:33 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:41823 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfJ2Tec (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Oct 2019 15:34:32 -0400
Received: by mail-il1-f178.google.com with SMTP id z10so12392416ilo.8
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Oct 2019 12:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KtXRdLjYuwh8AAweNrED2u7IBcnYxxSBzIulixoAyag=;
        b=sv+f8w1WGbh9h2UqvZNUsCL0kQEHvQ8J84z6Zl8eqUvwn/dYhUTMK6gbUpTwciyfrk
         nkgmcULCjVuUO0LU0pHDuHrQQApkirLkHvjKjyntNCfYr40gQ6FDnPoSuu/oLAKtqOVU
         LyW/5N0vweXCNAQGrhd80YI8dTYpN8JF7dGF0ojnGDh0gcYafkwTIpUweF7b3AFopzQU
         7J6SE0iDJYkZCpKgB1ztAn1DcQLPZ1GA+5lcHcz82MtkPMTaF9v3MQmlBy6E0x/xxylT
         U5hcH7U7dEjVt0ukkMQiWaVC8yHrHvHmj6YxerpbUSQnsWZ9wYDdZoCg/Jq6aF1pVVjV
         dzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KtXRdLjYuwh8AAweNrED2u7IBcnYxxSBzIulixoAyag=;
        b=DxDKD3PFZFsNz+VJHVMOyX5z5Le6YX3EukKEIHDEvtiEgsHZKrxl/kNzwF9tT1aFRU
         elAE8fBqXMPNraBxDdZfY3luFeD24fyJgpr9C6CuGIYZgRjLrdrMzUbLNa9lceuLQak4
         3Jj90o9NFG6BxI1ZdQimd2+bSzc9ba116tdBwMnrqSmi2Xts86mCQvGpmq+JxR4lM4Ly
         1Jb97t05cJ0ufy5PVtYPa12HNaEikH64osK1iHdm3zVZb6tJFVYuT9unqISRhKOcFYQl
         LshpFC0izVEyIYSNcFaM2bN7SVjij322HUrrqdDwc8tUT1Q5iOs3UBUk+4E87TpFvaGg
         aJmQ==
X-Gm-Message-State: APjAAAW1Nx3iE/CyRRwTuwqQAnF8gOlHutwOe24sJvGNkLb+FugMan/n
        7HvqN/4XvOLhv8L7PVDxOz3ym0lopRHCIHh+DDYE/Ilhdh8=
X-Google-Smtp-Source: APXvYqzngdr09gfsPQD0VetFtIuZftlpkKM6lP2/LT49mRoxWOwE+1m3lkfALXRtcf2h08GVYkMAC5rCNYJD8u7SSHI=
X-Received: by 2002:a92:ab08:: with SMTP id v8mr29899982ilh.171.1572377671668;
 Tue, 29 Oct 2019 12:34:31 -0700 (PDT)
MIME-Version: 1.0
From:   liron atedgi <lironatedgi@gmail.com>
Date:   Tue, 29 Oct 2019 21:34:20 +0200
Message-ID: <CAE-X+Wf4hA_wZAHE9tqn5=fvxk9DVCHU5YjTfMCHQrk5M4nvsA@mail.gmail.com>
Subject: Invoke eventfd_signal within ISR with IRQF_NO_THREAD set
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi All,

I've an interrupt handler which registered with IRQF_NO_THREAD flag.
As part on the ISR, I would like to invoke eventfd_signal
(fs/eventfd.c:eventfd_signal) in order to wakeup some user thread
which "sits" on this event.

Since the ISR marked as NO_THREAD (which is what i need), the ISR will
be called within interrupt context, however, it seems that the
eventfd_signal function uses a spinlock which is not raw, hence, with
RT patch it is converted to rt_spin_lock which is actually a mutex and
hence, it's not an appropriate locking mechanism to be used in
interrupt,

I'll be glad for any help.

Appreciate your reply.

Regards,
Liron
