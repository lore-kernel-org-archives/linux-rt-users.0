Return-Path: <SRS0=Os7+=UY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B642C48BD5
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jun 2019 13:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3153213F2
	for <linux-rt-users@archiver.kernel.org>; Tue, 25 Jun 2019 13:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0qJmLBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbfFYNlK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:41:10 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43343 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfFYNlJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:09 -0400
Received: by mail-wr1-f54.google.com with SMTP id p13so17920922wru.10
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Jun 2019 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=3MWjAL7yADhYIXEbnp6v3WdQSF+qeCxFK65bgo/x2VI=;
        b=Y0qJmLBQV5wmuT4WyLIXVBvIwvNyKI32UCxL3xp/QOXZ4IKrZA7OTLL4eb0V7Dq8nb
         KekMXbne6DU3igwhOS2sYnusbPw2KJWoqibmvi7RoSTlQG+uYsf+6I0FNV3aqJzLYWbY
         k++cY5bRpgxHRyLyYqaeMICLVXK/K3DXPHeT0+kS3u46mS5Ze/n4DItBvP+Hkr78pPfa
         kDNpzYhnxAR/ZR3supYSQj1vCqJwhJuen+kcZC6Q9MP2fhYYVsePdGanvW3+afYRueqR
         iFiKwrcfsxd2Ioh+FVDh2B2XTny+wcaEm/P6Qo/wSbFgUhVnrmpX/mb+otcnsvH1x12J
         GGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=3MWjAL7yADhYIXEbnp6v3WdQSF+qeCxFK65bgo/x2VI=;
        b=T+Uclt637iaYRPKQUweFjpo29gfya+7Dd18u9BSMer4oB3yd5fUYfipuNQRuAdNBQA
         QVoWx2FhrUn88HS7b5cMb0G4wIVR5/OKLOQM0P4mxILFaJrZWPcfG/lRMzsMRhqvENfk
         n2m02Ks3cy56F5lCEazxXzdOh54wI0RQOF/34w5hP018qlCV/X3fymscIfvp06izD0/X
         hLO1LHq+dII6oxKeX0gID9J9hnfcGXEIMtqis4aBx8L/YIWm0I3aRCXQ4ZGxyWqpcPaA
         0QnQM1xxMYIN/IzVqj5sl9dY7qEmmlLSBfx6uSYiIm1kaeDT5wxtWlmVal9Ra+oGKhOM
         VyPw==
X-Gm-Message-State: APjAAAWF0dk3ufLHyYU45dmkcBYJH7g9QSXya31DPXx/nc8Dn+08uLyM
        oRw7Qz00Ml127IFeEAgHLlXccBECXjpdvg7Z8TwG7mpQ
X-Google-Smtp-Source: APXvYqzlq/mOeC1278ywIRf+8MCktzY6fRQOXVtiQmCrpWVW617uRK9PK7j2g99ufCFzynOxU0N0LElHBtcegrmBNCg=
X-Received: by 2002:adf:f34b:: with SMTP id e11mr29532461wrp.230.1561470067253;
 Tue, 25 Jun 2019 06:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAL8zT=hcP=z_iM+rcUcaTOXLMqVDVn=gbnybp-Q-cmAyKJCzUg@mail.gmail.com>
In-Reply-To: <CAL8zT=hcP=z_iM+rcUcaTOXLMqVDVn=gbnybp-Q-cmAyKJCzUg@mail.gmail.com>
From:   Jean-Michel Hautbois <jhautbois@gmail.com>
Date:   Tue, 25 Jun 2019 15:40:56 +0200
Message-ID: <CAL8zT=hmt939+2hUN-bine0bk5vq=RMtzdWqsOoog16LRxv2cg@mail.gmail.com>
Subject: Fwd: Question about PREEMPT_RT and wakeup_rt latency
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I am currently using for a customer a 5.0.19-rt11 on an i.MX6 and it
works very well ! :)

I have a latency issue, and tried to use wakeup_rt latency to detect
it but I am not sure to really understand the output of ftrace...
From what I understand, the interrupt "irq/28" is having a latency of
~2ms ?? It sound like a very big latency !

And this customer has forced affinity and priorities on its threads,
and I think it could explain such a behaviour ? For instance the task
named "tLaserLo-762" is in fact forced with an affinity of 2 and a
priority of SCHED_FIFO 30.

https://framabin.org/p/?e63c638b5cf2e4ec#GS6ahFDEI/m6vyY2lwafB96vbgA4Skft1d+Dvtry2QI=

I think it gives a very nice example of what preemption really is, but
it can be confusing.
Can it be traced with kernelshark or something else ?

Thanks,
JM
