From: Grammostola Rosea <rosea.grammostola@gmail.com>
Subject: Re: [Fwd: Re: realtime kernel for Debian]
Date: Wed, 25 Mar 2009 11:37:54 +0100
Message-ID: <49CA0982.5090404@gmail.com>
References: <49C8FF4D.1040204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: pkg-multimedia-maintainers@lists.alioth.debian.org,
	linux-audio-user <linux-audio-user@lists.linuxaudio.org>,
	linux-rt-users@vger.kernel.org, 64studio-devel@lists.64studio.com,
	Musix
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpq2.gn.mail.iss.as9143.net ([212.54.34.165]:35796 "EHLO
	smtpq2.gn.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753469AbZCYKlK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Mar 2009 06:41:10 -0400
In-Reply-To: <49C8FF4D.1040204@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Grammostola Rosea wrote:
> Hi,
>
> There is an promising discussion on the debian-dev mailinglist. Maybe 
> some people who knows more about realtime kernels could join. Also 
> users who might want to have an realtime kernel in Debian and/or want 
> help testing could join the discussion. I think it would be nice if 
> there is also an realtime kernel in Debian or that the default kernel 
> would be improved for realtime (audio) usage.
>
>
> http://www.debian.org/MailingLists/subscribe
Here is the thread about a realtime kernel in Debian:


http://www.linux-archive.org/debian-development/268999-realtime-kernel-debian.html


Kind regards,

\r






>
> \r
>
> ------------------------------------------------------------------------
>
> Subject:
> Re: realtime kernel for Debian
> From:
> "Giacomo A. Catenazzi" <cate@debian.org>
> Date:
> Tue, 24 Mar 2009 13:26:35 +0100
> To:
> debian-devel@lists.debian.org
>
> To:
> debian-devel@lists.debian.org
>
>
> Raphael Hertzog wrote:
>> On Tue, 24 Mar 2009, Giacomo A. Catenazzi wrote:
>>> Do you really need real time kernel?
>>> Debian is a technical driven project, but reading the previous two 
>>> quotes,
>>> "real time" is used as marketing thing.
>>
>> It's good to question the use of any feature, but a real-time kernel is
>> certainly very useful in many industrial applications and Debian is
>> popular in that field. (Don't put a marketing label on anything where
>> you are not yourself sure of your expertise.)
>
> Yes, I didn't write very well my sentence: the previous quotes was more
> about "there exist rt kernels", "ubuntu has a rt kernel", but not solid
> requirements. I had to write some "seems", and I'm sorry for the two
> quoted people if it seems an attack.
> Anyway, later in the mail, I asked for precise needs, so we could see
> better what we should improve.
>
> IMHO most users want a low latency kernel, but not a slower kernel, so
> a CONFIG_HZ_1000 would be nice.  But the original post was about
> multimedia production (and not reproduction), so the needs are probably
> other.
>
> My point was more:
> - Debian has not rt kernel. Why? Non DD interested or/and low demand?
>   This is an important point. We must not produce a rt-kernel if
>   we cannot provide testers and developers (in unstable).
> - kernel management is a weak point in distribution: no good method
>   for kernel dependencies, using full capabilities, ...
>
> so IMHO we should try harder with the normal kernel, so that we
> can use the same infrastructure and testers. If we fail and we
> are able to support rt kernels, IMO it is good to provide it in Debian.
>
> The original mail was about "multimedia production" and few year ago 
> kernel
> developers had a lot of interaction with music industries.
> I'm not an expert in the field, but how far are we in their need with
> standard kernels?)
>
>
>> I do use a real-time kernel on a Debian based system for one of my
>> customers (but I have to recompile the kernel anyway because I do other
>> customizations) and I have good reasons to do so because I can't suffer
>> serial overrun and I must ensure that the serial interrupt handler
>> is run in the required time and that no other (kernel) task has higher
>> priority.
>
> These *other customizations* are important to rt-kernel. So we need
> a person (or more) that know the needs and could support us.
> "realtime" alone is only a label ;-)
>
> ciao
>     cate
>
>

