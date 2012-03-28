From: "Wolfgang Wallner" <wolfgang-wallner@gmx.at>
Subject: Re: Determining latest stable release.
Date: Wed, 28 Mar 2012 22:27:19 +0200
Message-ID: <op.wbwdrtr2uqv2j3@woifes-laptop>
References: <CAOHJ0jTVxzgfBK=GSEr14YrpFZEqFE_qDqftaUgGWDgm344NNg@mail.gmail.com> <CAOHJ0jQphT30v-y1HMiHYOnFVumovkccCV43mDJjBx=fko=GUg@mail.gmail.com> <20120328140022.2998bfbc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org
To: "Clark Williams" <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:57522 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932761Ab2C1U1U (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Mar 2012 16:27:20 -0400
In-Reply-To: <20120328140022.2998bfbc@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


What is the relation between these stable releases and what the OSADL  
calls 'latest stable'? [1]

Regards, Wolfgang


[1]  
https://www.osadl.org/Latest-Stable-Realtime.latest-stable-realtime-linux.0.html



On Wed, 28 Mar 2012 21:00:22 +0200, Clark Williams <williams@redhat.com>  
wrote:

> On Tue, 27 Mar 2012 15:59:31 -0500
> Robert Barrows <Robert.Barrows@metriainnovation.com> wrote:
>
>> Does the PREEMPT_RT patch have a method of determining latest stable
>> release?
>>
>> I notice that 3.0.35 goes up to rt44 was declared a stable release but
>> so was rt43
>> Now 3.2.12 goes up to rt22, and that was updated March 23rd with  
>> 3.0.35-rt44.
>>
>> Is there a reason to think that 3.0.35-rt44 is more stable than  
>> 3.2.12-rt22?
>> The real question is: is there a rule of thumb on how you would choose
>> a rt patched kernel for a production machine?
>>
>> Thanks.
>>
>> -Robb Barrows
>> --
>>
>
> The stuff that Steven releases is the stable series, while Thomas
> does the devel releases. So if you're not looking for the latest and
> greatest, I'd stick to what Steven releases.
>
> Clark
