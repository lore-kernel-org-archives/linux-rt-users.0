From: Brian Wrenn <dcbrianw@gmail.com>
Subject: Re: How to write RT applications ?
Date: Tue, 21 Mar 2017 13:08:40 -0400
Message-ID: <CAEYdEeR=04qszshTum6mbCwj_H53uLwwgbE4YDnDh1hHYqP7UQ@mail.gmail.com>
References: <CAJ2oMhJp-uBxxj7tyPHM2M9cFnjhus4ORYYfFgNywaMFXS4Q9Q@mail.gmail.com>
 <20170317201741.bwwycyl5ggbpjksw@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ran Shalit <ranshalit@gmail.com>, linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36328 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933599AbdCURRh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Mar 2017 13:17:37 -0400
Received: by mail-it0-f68.google.com with SMTP id 190so2254263itm.3
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Mar 2017 10:17:36 -0700 (PDT)
In-Reply-To: <20170317201741.bwwycyl5ggbpjksw@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've tried to find a way to use ::std::thread or ::boost::thread to
accomplish what the article for creating a simple RT application with
pthreads does, but unfortunately I don't think those two OOP
approaches provide enough attribute configuration to suffice.  Has
anyone else found otherwise?

On Fri, Mar 17, 2017 at 4:18 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2017-03-02 15:52:32 [+0200], Ran Shalit wrote:
>> I know it is different concepts, yet, I wander if in RT Linux there
>> are also similar ideas, that should be taken care of when writing
>> application, in order to be assure that real time threads behave as
>> expected.
>
> Our wiki moved
>   https://wiki.linuxfoundation.org/realtime/documentation/howto/applications/start
>
> and there are two articles about simple RT applications.
>
>> Thank you!
>> Ran
>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
