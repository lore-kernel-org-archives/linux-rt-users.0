From: "Uli Brueggemann" <uli.brueggemann@gmail.com>
Subject: Re: Different kernel and RT versions
Date: Fri, 30 May 2008 08:45:59 +0200
Message-ID: <10a58eee0805292345l12789ff6xc66d5d0e9e54a879@mail.gmail.com>
References: <10a58eee0805290530r3618ae6ap6cf69aab91c61e28@mail.gmail.com>
	 <10a58eee0805290531lc6ac67cm6d808197b0d41d35@mail.gmail.com>
	 <10a58eee0805290533v32e95d76x25e8fd9954700ee9@mail.gmail.com>
	 <3efb10970805291148u54bff041v5c4ea104d9b9f325@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Remy Bohmer" <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:60875 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbYE3Gp7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 30 May 2008 02:45:59 -0400
Received: by wa-out-1112.google.com with SMTP id j37so3689591waf.23
        for <linux-rt-users@vger.kernel.org>; Thu, 29 May 2008 23:45:59 -0700 (PDT)
In-Reply-To: <3efb10970805291148u54bff041v5c4ea104d9b9f325@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Remy,

I like to have a low latecy predictable system.
And I know the rt.wiki.kernel.org webpage.
Also for example
http://www.diyaudio.com/wiki/index.php?page=LINUX+Audio which is
referencing zen-sources.

But I would like to understand rt differences. That's what I have
asked for. From viewpoint of application, I do not have a deep Linux
or even kernel knowledge. Or do all the latest rt developments simply
have no meaning or effect on the application?

Best

Uli

On Thu, May 29, 2008 at 8:48 PM, Remy Bohmer <linux@bohmer.net> wrote:
> Hello Uli,
>
>> I like to use Linux for audio purposes.
>> So of course I'm interested in getting a best performance.
>
> What do you mean exactly with 'performance' ? (speed versus 'a nice
> play/showtime')
>
> Realtime is not about performance (in the sense of speed), it is about
> determinism.
>
> So, if you want a fast system, you probably do not want realtime.
> If you want a predictable (low latency) system, you could think about realtime.
>
>> Can someone explain me how to select a kernel and the rt-version? What
>> are advantages/disadvantages under realtime aspects?
>
> Already looked on http://rt.wiki.kernel.org ??
>
>
> Kind Regards,
>
> Remy
>
>>
>> Now I can see that there are constant updates of rt-versions:
>> - 2.6.24.7 now there is rt11
>> - 2.6.25.4 we have rt3
>> - 2.6.26-rc4 no rt work yet published
>>
>> It seems that the rt-versions for the different kernels are maintained
>> in parallel but e.g. last updates have been for 2.6.24.7
>>
>> Can someone explain me how to select a kernel and the rt-version? What
>> are advantages/disadvantages under realtime aspects?
>>
>> Thanks
>>
>> Uli
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
