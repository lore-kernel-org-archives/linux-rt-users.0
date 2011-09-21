From: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Subject: Re: 3.04-rt14 patch applies against which version?
Date: Tue, 20 Sep 2011 17:17:14 -0700
Message-ID: <4E792D0A.5070209@caviumnetworks.com>
References: <4E791F5D.8000105@caviumnetworks.com> <CAFQPvXcEjWod1k-UWjJ1AKwUtD+oGfXtqDd7xOVRGvKtfVpUrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sankara Muthukrishnan <sankara.m@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16202 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441Ab1IUAZA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Sep 2011 20:25:00 -0400
In-Reply-To: <CAFQPvXcEjWod1k-UWjJ1AKwUtD+oGfXtqDd7xOVRGvKtfVpUrQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks for the link.

I pulled this git repo from  
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git about 
a couple of weeks agon and I see only these tags for 3.0

....../linux.git.mainline$ git tag | grep 3.0
v3.0
v3.0-rc1
v3.0-rc2
v3.0-rc3
v3.0-rc4
v3.0-rc5
v3.0-rc6
v3.0-rc7

Thanks,
Venkat



On 09/20/2011 05:16 PM, Sankara Muthukrishnan wrote:
> I think v3.0-rc4 is different from v3.0.4. You should use v3.0.4. As
> kernel.org is down, I can't point you to the git tree details. For
> instance, you can use the following mirror:
> http://mirror.yandex.ru/kernel.org/linux/kernel/v3.0/linux-3.0.4.tar.bz2
>
> Thanks,
> Sankara
>
> On Tue, Sep 20, 2011 at 6:18 PM, Venkat Subbiah
> <vsubbiah@caviumnetworks.com>  wrote:
>> Hello RT
>>
>> Got the 3.0.4-rt14 patch  from the link in the message below and tried to apply this to the v3.0-rc4 tag from the linux mainline git repo. It didn't apply cleanly and I got a couple of rejects. So was wondering whether I am applying it against the correct version of the kernel? Against which tag in the repo does this apply against?
>>
>> http://www.spinics.net/lists/linux-rt-users/msg06997.html
>>
>> Thanks,
>> Venkat
>>
>>
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

