Return-Path: <SRS0=hjoW=WL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1CEC3A589
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8E6208C2
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 13:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8U2CVQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbfHONbD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:31:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43388 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbfHONbC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Aug 2019 09:31:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8so2207260wrn.10
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Aug 2019 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Gc24i+ADeGl5GmPmYJ2P+bDpzGS14YvtsEHbL9psAE=;
        b=k8U2CVQdvkA9300Ez6JjKUnzI0DwiNhEf7yvZMj1ShE3fjTxaafj/0UCam7z584TKu
         IpRc88E+vf9GeOxtvjqRN5siL7Us7x5aKWwa6adJJdH/nJFo8g/gesLdBfr9XE+wDCY/
         e0KgF8Me6Hl7ziQQM+F0jjIoAF6pZEhCbyVrpwpZmviWitTy7XJ/BDvbbn8pS/Yfc2X6
         P7fSOTlWAAOt3+szt6OTwFNO430gj5bLmQ4b5/YLTN/sl3q+PkmFYvTPJYqL8nrAvr/9
         E9A5qM31rNEt0vhoUOWjT46ZBxjtRlhYe4LWSC1IS2w/hAJ45PzIpXij8FULHIXYmOL/
         PBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Gc24i+ADeGl5GmPmYJ2P+bDpzGS14YvtsEHbL9psAE=;
        b=px4omvwN9rndUhMBBatbiqXYAqDi/kpuhakgcoarjPECeASl0J5XkKN/n6d+mhZmUA
         RXUTJerCc5xn80FtKSoeXghZ0x5n7PSfRUpvxEv9rYbLD76hdqz6mR/UYgvFRkiSDotq
         /BNhB2ZMRz8G4gupZPgfevN/XUU0uRJtB5DKBcqD3gkgWPrtdNB8T9gvzsc+xdaUh7Dj
         KepUjaNZtjCkH5TsFpSPRdcbM7xtmRLjkM7YK95EgkWIqMMgSbK8HEdGEDqHGRUQDfwf
         H+zuC2mU9V+U+1Fod7HdwzNF2tnR04FEtUL3UK40fnkl36SLchTzeIRVjeQUdfiCYvr3
         u9AQ==
X-Gm-Message-State: APjAAAWgt9piV1CVbQUYKKCXt4Ouuu/scPsj/zzh2q0+BLWBDqRLONKi
        XCis+Nbw0fBDqKvRNxqZDksaYI9F8LBapyhZkls=
X-Google-Smtp-Source: APXvYqxc9kYTKP8B/mOtDPxkj5RRMoL/a3DAtX0XnWcWdIO8S2yeLd4eP686n60nQyt/I9mMU+Li/iE3t92NC65cZtU=
X-Received: by 2002:a5d:4bc1:: with SMTP id l1mr5664033wrt.259.1565875860490;
 Thu, 15 Aug 2019 06:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAD56B7eswTRxbeA8foXyVVZ7Bd+_y40dtOLkHxuAf4kVge7VDg@mail.gmail.com>
 <alpine.DEB.2.21.1907171001150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171009280.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171101150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171220400.1767@nanos.tec.linutronix.de>
 <CAD56B7eomeb5Lr2juFWtZmtqSx3SkPijW03QZz8xv39He26PrA@mail.gmail.com>
 <20190813095306.xqgq3uusdpj7dhy7@linutronix.de> <CAD56B7fqosJAhiCLikhcxv_3wY7ETOv++kmQcr-=9NKEGq7Agw@mail.gmail.com>
 <20190814112656.z3de2rgbqzpaquz5@linutronix.de> <CAD56B7ezpaONhXCddu6RTE33-iXG7+J=xf417xu_uT-YKPV6RQ@mail.gmail.com>
 <20190815082955.olo3phbqj6disk3q@linutronix.de> <87a7ca4nh6.fsf@linutronix.de>
In-Reply-To: <87a7ca4nh6.fsf@linutronix.de>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Thu, 15 Aug 2019 09:30:48 -0400
Message-ID: <CAD56B7fAsv-f8nnZE9OXzdomsYfcvOOaFun1bh57dLt6Ee3ZFA@mail.gmail.com>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> Where in this trace is there a latency spike? I could not see one.
Hi John,

For the 5.2.0-rt1 trace data set I believe the latency is with
cyclicte-1935 at the end. If I just look at the "cyclicte-1935 ...
finish_task_switch <-__schedule" lines then the delta-t's are mostly
around 200us except for the last delta-t which is >5000us
cyclicte-1935    1d...3.. 84243668us : uao_thread_switch <-__switch_to
cyclicte-1935    1d...3.. 84249436us : finish_task_switch <-__schedule

The actual cyclictest output is shown below:
# ./cyclictest -S -m -n -p 99 -i 200 -h 700 -f -b 5000
# /dev/cpu_dma_latency set to 0us
INFO: debugfs mountpoint: /sys/kernel/debug/tracing/
policy: fifo: loadavg: 5.55 1.84 0.66 11/136 1941

T: 0 ( 1934) P:99 I:200 C: 411188 Min:     30 Act:   30 Avg:   93 Max:     652
T: 1 ( 1935) P:99 I:200 C: 382925 Min:     47 Act: 5713 Avg:  123 Max:    5713
T: 2 ( 1936) P:99 I:200 C: 395011 Min:     40 Act:   40 Avg:  117 Max:     561
T: 3 ( 1937) P:99 I:200 C: 392379 Min:     36 Act:   36 Avg:  109 Max:     636

thanks,
Paul
