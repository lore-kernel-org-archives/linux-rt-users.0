From: Pradyumna Sampath <pradysam@gmail.com>
Subject: Re: mq_timedrecieve timeout accuracy
Date: Wed, 24 Mar 2010 14:47:03 +0100
Message-ID: <6d09081c1003240647w452e991fgcf70e2edce746ae7@mail.gmail.com>
References: <6d09081c1003240527r471ee34etbba11b4b7c7e92b3@mail.gmail.com>
	 <8226231.1269436934345.JavaMail.ngmail@webmail10.arcor-online.net>
	 <6d09081c1003240637w28ee6861tfcef4c7876ef3e40@mail.gmail.com>
	 <921ca19c1003240645s5c69fde9l464618ec7aa644af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "M. Koehrer" <mathias_koehrer@arcor.de>,
	linux-rt-users@vger.kernel.org, rachana.rao@in.abb.com
To: Sujit K M <sjt.kar@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:59748 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671Ab0CXNrF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Mar 2010 09:47:05 -0400
Received: by ewy8 with SMTP id 8so1219667ewy.28
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Mar 2010 06:47:04 -0700 (PDT)
In-Reply-To: <921ca19c1003240645s5c69fde9l464618ec7aa644af@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 24, 2010 at 2:45 PM, Sujit K M <sjt.kar@gmail.com> wrote:

> Fine.
>
>> Maybe this is why produces a timeout that is inaccurate. Shouldnt it
>> be schedule_hrtimeout ?
>
> Does the RT Patch change anything. OR is it the same.
>

I dont have a vanilla kernel on this piece of hardware. But, I would
guess these numbers are not really expected out of the RT_PREEMPT
kernel ? Im not sure if anyone has run any kind of benchmarks with
ipc's .. message queues in particular.

regards
/prady

-- 
http://www.prady.in
