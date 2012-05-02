From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RFC] rt-tests: Makefile get machinetype from compiler
 instead of uname
Date: Wed, 2 May 2012 14:01:44 -0700
Message-ID: <4FA1A0B8.4090705@am.sony.com>
References: <4FA09D25.7090808@am.sony.com> <4FA19963.3030104@linux.intel.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:20088
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756799Ab2EBVCM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 May 2012 17:02:12 -0400
In-Reply-To: <4FA19963.3030104@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/02/12 13:30, Darren Hart wrote:
> On 05/01/2012 07:34 PM, Frank Rowand wrote:
>>
>> Fix the machinetype check for cross-compiling.
>>
>> This has been tested on an x86_64  Fedora host for an x86_64 target and
>> an ARM target.  Additional testing would be greatly appreciated.
> 
> 
> Built in Yocto using an ARM cross compiler and ran cyclictest in qemuarm
> with the resulting image. Appears sane.
> 
> What problem manifested before?
> 
>>
>> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> 
> Tested-by: Darren Hart <dvhart@linux.intel.com>

Thanks!

As you and jkacur surmised, the problem I'm trying to fix is that
the machinetype got the host machine type instead of the target
machine type.  Could definitely word the description better...

-Frank

