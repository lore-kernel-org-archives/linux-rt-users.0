From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: Linearized 2.6.33.7-rt30 patch set available (with free coffee!)
Date: Mon, 31 Jan 2011 17:07:14 -0800
Message-ID: <4D475CC2.5080302@am.sony.com>
References: <4D47242E.1000508@am.sony.com> <4D4725CF.6060008@windriver.com> <4D473046.8090009@am.sony.com> <4D474736.40703@windriver.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:15140 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147Ab1BABHo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Jan 2011 20:07:44 -0500
In-Reply-To: <4D474736.40703@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/31/11 15:35, Paul Gortmaker wrote:
> On 11-01-31 04:57 PM, Frank Rowand wrote:
>> On 01/31/11 13:12, Paul Gortmaker wrote:
>>> On 11-01-31 04:05 PM, Frank Rowand wrote:
>>>> Hi Paul,
>>>>
>>>> Thanks for the patch set!  I had started down the path of doing
>>>> the same work, and truly appreciate the effort you put into this.
>>>>
>>>> One of the patches had a chunk that failed to apply:
>>>>
>>>> genirq-support-forced-threading-of-interrupts.patch
>>>
>>> Interesting.  I was using "git am" to apply them, and I can assure
>>> you that they all applied with that (which is quite strict in its
>>> checking.)
>>>
>>> What were you applying them with?
>>
>> quilt push -a
> 
> OK, so it is simply a matter of quilt dying while git am is capable
> of doing the right thing (see below for evidence).  I'll re-export all
> the patches on the v2.6.33-rt branch, which will fix you up.  Should
> be able to do that shortly -- check the gitweb page for activity on
> the v2.6.33-rt branch, which is what you want to use.

I'll watch for that and check it again.

> 
> You do realize that by using quilt though, that you are throwing away
> all the commit headers and the history, which is the whole point of
> this tree existing?   

Yes.  I do find great value in the history -- it is very informative.

> You are just building up the original RT giant
> diff one chunk at a time.  Unless you are thinking or intending to
> insert some other SCM into the quilt processing at each step, I don't
> see the point of using quilt and doing a "push -a"

I wasn't to the point yet of importing the patches into an SCM.  I was
just checking that the patches applied and that they are equivalent to
the patch set you started with.  Think of it as a simple consistency and
paranoia check that a reviewer would do.

I used quilt because it is a trivial manual method of applying all the
patches, since they are nicely listed in the proper order in the series
file.

-Frank

