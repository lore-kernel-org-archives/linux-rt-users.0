Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-oi0-f43.google.com ([209.85.218.43]:44949 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732209AbeGaPaM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Jul 2018 11:30:12 -0400
Received: by mail-oi0-f43.google.com with SMTP id s198-v6so28031085oih.11
        for <linux-rt-users@vger.kernel.org>; Tue, 31 Jul 2018 06:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAF_dkJC2UqpDVGzF4K575_hZYii_-OL6H1h=nNO8mTQm4QK2SQ@mail.gmail.com>
 <20180730205931.GL29574@jcartwri.amer.corp.natinst.com> <CAF_dkJAHfM6QO7UUeyf8YqVmniDLrhBJoVkVJvGwfPC8rED42Q@mail.gmail.com>
 <4333850.dc08gExWjP@ada>
In-Reply-To: <4333850.dc08gExWjP@ada>
From: Patrick Doyle <wpdster@gmail.com>
Date: Tue, 31 Jul 2018 09:49:20 -0400
Message-ID: <CAF_dkJDV0t7Cp7xjW2j9teJRU45anfKMJMO6KpU+ewTVmW0J4A@mail.gmail.com>
Subject: Re: How to apply RT patches to a kernel not listed in http://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: ada@thorsis.com
Cc: linux-rt-users@vger.kernel.org

On Tue, Jul 31, 2018 at 3:42 AM Alexander Dahl <ada@thorsis.com> wrote:
> Hei hei,
>
> Is there any particular reason to use that tree instead of running vanilla
> which has good at91 support, also in v4.9?
>
> (I am using PREEMPT_RT on top of vanilla v4.9.x with an at91sam9g20.)
That's an excellent question!  (As my college instructors used to say
when I asked a question to which they did not know the answer.)

I guess I have always assumed that the linux-at91 tree was more
betterer for the SAMA5 than the vanilla tree.  But I have never asked
what makes it better.  I do admire and applaud Atmel/Microchip's
commitment to getting their changes mainlined.

--wpd
