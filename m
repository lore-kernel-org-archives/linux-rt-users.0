From: =?windows-1252?Q?St=E9phane_ancelot?= <sancelot@numalliance.com>
Subject: Re: rt patch
Date: Thu, 11 Jun 2015 08:23:29 +0200
Message-ID: <55792961.8080002@numalliance.com>
References: <5576FC70.8050908@numalliance.com> <CABgxDo+cC7n8AbWvuwRrUWj-08DvtApL78OsqX66gN7U519iXA@mail.gmail.com> <5577DCE0.3000805@numalliance.com> <CABgxDoJdNJMc3tE1=pzhP-=VsSB6irPT7q3_CPJpJJuGwSwRmA@mail.gmail.com> <5577E019.6030106@numalliance.com> <20150610144047.GB31886@zipoli.ccur.com> <00f101d0a394$d66f73a0$834e5ae0$@pont@sdcsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: 'Romain Perier' <romain.perier@gmail.com>,
	linux-rt-users@vger.kernel.org
To: andy.pont@sdcsystems.com, 'Joe Korty' <joe.korty@ccur.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.numalliance.com ([83.206.84.204]:39180 "EHLO
	mail.numalliance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbbFKGXm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jun 2015 02:23:42 -0400
In-Reply-To: <00f101d0a394$d66f73a0$834e5ae0$@pont@sdcsystems.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/06/2015 17:47, Andy Pont wrote:
> Hi Joe,
>
> [snip]
>
>> This sequence works for me:
>>
>>     cd
>>     mkdir junk
>>     cd junk
>>     wget -q ftp://ftp.kernel.org/pub/linux/kernel/v3.0/linux-
>> 3.18.11.tar.xz
>>     wget -q
>> ftp://ftp.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.13-
>> rt10.patch.xz
>>     tar xf l*xz
>>     cd linux*11
>>     unxz <../pat*xz | patch -p1
>>
>> There are some (annoying) offset errors, but no fuzzies or rejects like
>> you have been seeing.
>
> I think the reason you see offset errors is that you are trying to patch
> 3.18.11 with the 3.18.13 RT patch.  A quick test here substituting with :
>
> 	wget -q
> ftp://ftp.kernel.org/pub/linux/kernel/v3.0/linux-3.18.13.tar.xz
>
> gives no such errors!
>
> Andy.
>
It looks like this is a proxy related problem....

using wget I am unable to use ftp://, but http:// is downloading, 
however this does not work with the files retrieved.

can you give me working md5sum of files downloaded ?
Regards,
Steph
