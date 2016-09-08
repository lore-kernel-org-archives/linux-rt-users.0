From: Jens Koehler <jenskxxx@googlemail.com>
Subject: Re: hrtimer: interrupt took 10252 ns - meaning?
Date: Thu, 8 Sep 2016 12:36:08 +0200
Message-ID: <CAL7_A_WcvqmghJiQaDdnYRZmPf9=-s3eveMfM1uYtHfKykbmVg@mail.gmail.com>
References: <CAL7_A_VUiLH9JBkL8HBrUaAn6_yF+3jefXHMwGFS8Sr4g29q0A@mail.gmail.com>
 <9f943b0e-12f5-2779-0bba-c4bc2b7357fa@linutronix.de> <20160808164505.GA13707@linutronix.de>
 <CAL7_A_Vz+BCg-QXraob1ndDF4b3ggGN-j+fnQ9FTqY1FdbVvug@mail.gmail.com> <20160812123735.zboeocbv4o5sjnwb@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:36581 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941231AbcIHKgJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Sep 2016 06:36:09 -0400
Received: by mail-ua0-f178.google.com with SMTP id b7so36471297uab.3
        for <linux-rt-users@vger.kernel.org>; Thu, 08 Sep 2016 03:36:09 -0700 (PDT)
In-Reply-To: <20160812123735.zboeocbv4o5sjnwb@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Sebastian,

After adding of your patch "disable preemption during CR3 read+write"
we have since 2 weeks no rt throttling event. This is very good
improvement.

Thanks a lot,
Jens
