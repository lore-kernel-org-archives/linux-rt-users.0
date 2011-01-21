From: Bruce Ashfield <bruce.ashfield@gmail.com>
Subject: Re: RT on 2.6.34
Date: Fri, 21 Jan 2011 16:46:22 -0500
Message-ID: <AANLkTi=Zn+7xm2AH7uU0SoUkUoAbfNE86hmogu=WfyG9@mail.gmail.com>
References: <4CAC19EE.1010208@gmail.com>
	<20101008020925.GB14157@ubuntu.mshome.net>
	<87aampt8e0.fsf@eha.doredevelopment.dk>
	<20101008083700.GC14157@ubuntu.mshome.net>
	<AANLkTimC+5r9vz3pQrfn3fNfkhsrcjpMJ8g63weoGj_c@mail.gmail.com>
	<4D376720.1030900@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: walimis <walimisdev@gmail.com>,
	Esben Haabendal <eha@doredevelopment.dk>,
	Sven-Thorsten Dietrich <thebigcorporation@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52426 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab1AUVqW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jan 2011 16:46:22 -0500
Received: by mail-iw0-f174.google.com with SMTP id 9so2136676iwn.19
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Jan 2011 13:46:22 -0800 (PST)
In-Reply-To: <4D376720.1030900@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jan 19, 2011 at 5:35 PM, Frank Rowand <frank.rowand@am.sony.com> wrote:
> On 10/08/10 10:47, Bruce Ashfield wrote:
>> On Fri, Oct 8, 2010 at 5:37 AM, walimis <walimisdev@gmail.com> wrote:
>>> On Fri, Oct 08, 2010 at 10:07:35AM +0200, Esben Haabendal wrote:
>>>> walimis <walimisdev@gmail.com> writes:
>>>>
>>>>> On Tue, Oct 05, 2010 at 11:40:46PM -0700, Sven-Thorsten Dietrich wrote:
>>>>>> If I read this correctly, WR ported RT to 2.6.34.
>>>>>>
>>>>>> Anyone out there to confirm?
>>>>> Yes, it's true.
>>>>
>>>> Ok, where do I download this from?
>>> there is a open source version of windriver kernel:
>>> git://git.pokylinux.org/linux-2.6-windriver
>>> please try "preempt_rt" branch.
>>
>> Please do NOT try this branch. It is only being updated now and
>> is not up to date.
>
> Bruce,
>
> Is there now an up to date version of the 2.6.34 windriver RT patches
> that we can access?

Hi Frank,

There will be one shortly, this is being worked on several fronts. I have
an update to the yocto branches that brings it up to date with to capture
some stability fixes from -tip and other sources. There are also other
efforts to fixup the series to work with a stock 2.6.34 that should be ready
in the not to distant future. We are trying to hit the middle ground of
cleaning up the presentation of this, but not waste effort by working through
changes that are already being done as the -rt patch is updated to
newer kernels.

What currently is in the yocto preempt_rt branch will boot, but still has a
few things I need to change (I'm held up deciding if doing a non-fastforward
merge is acceptable:)

Cheers,

Bruce

>
> Thanks,
>
> Frank Rowand
>
>



-- 
"Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end"
