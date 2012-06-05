From: Yang Honggang <eagle.rtlinux@gmail.com>
Subject: Re: file system bug
Date: Tue, 05 Jun 2012 03:35:35 -0400
Message-ID: <4FCDB6C7.1060003@gmail.com>
References: <4FC77A06.2090706@gmail.com> <alpine.LFD.2.02.1206041525150.3086@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, rtlinux@163.com,
	=?UTF-8?B?5p2o5rCR5by6?= <mqyoung@gmail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45867 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756129Ab2FEHeW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jun 2012 03:34:22 -0400
Received: by pbbrp8 with SMTP id rp8so7121464pbb.19
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Jun 2012 00:34:22 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1206041525150.3086@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/04/2012 09:26 AM, Thomas Gleixner wrote:
> On Thu, 31 May 2012, Yang Honggang wrote:
>    
>> Hello,
>>
>> There is no rt patch from 2.6.34  until 3.0. It said that the reason is that
>> there
>> is a serious file system bug which will cause file corruption.
>> And the bug is fixed by Thomas until the version 2.6.38??
>>
>> It will be very grateful if  some detail information about this bug can be
>> given.
>>      
> The bug was only visible with the changes RT did to that
> code. Mainline papered over it somehow, but I forgot the details by
> now.
>    
Where can I find the information about this bug?

thx,

Joseph
