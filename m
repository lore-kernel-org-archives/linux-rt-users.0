From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH] RFC - rt-tools: Detect whether numa is available at build
 time
Date: Wed, 30 May 2012 14:48:01 -0700
Message-ID: <4FC69591.30806@am.sony.com>
References: <1337989189-17563-1-git-send-email-jkacur@redhat.com>	<4FC41D20.1010105@am.sony.com> <CAONaPpE0eezsxwmWXV5zkavkEYiYHRXHX6EBBYOVw0W6vuvnCg@mail.gmail.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:55393
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757174Ab2E3Vsa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 May 2012 17:48:30 -0400
In-Reply-To: <CAONaPpE0eezsxwmWXV5zkavkEYiYHRXHX6EBBYOVw0W6vuvnCg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/30/12 12:58, John Kacur wrote:
> On Tue, May 29, 2012 at 2:49 AM, Frank Rowand <frank.rowand@am.sony.com> wrote:
>>
>> On 05/25/12 16:39, John Kacur wrote:
>>> This is a preliminary hack, I need to clean it up a little, but incase
>>> you
>>> want to give it a try, here is the alpha version.
>>>
>>> Note - I stole this methodology from tools/perf
>>>
>>> Signed-off-by: John Kacur <jkacur@redhat.com>
>>
>> I knew I would regret suggesting this fix.
>>
>> It works fine on my fedora 12 x86_64 system for native build.
>>
>> It works fine on my fedora 12 x86_64 system for crossbuild for ARM.
>>
>> The NUMA=0 option is still useful (thank you for leaving that
>> in place).  I have a second ARM target board, where the cross
>> linker does not complain about libnuma, so cyclictest is
>> build with libnuma.  But my run time environment does not have
>> a libnuma.  Ah the joy of pre-release file systems.  The NUMA=0
>> option allowed me to properly build cyclictest to run on this
>> not quite yet finished file system.
>>
>> Tested-by: Frank Rowand <frank.rowand@am.sony.com>
>>
> 
> Thank you very much for testing my quick hack. (tglx has anointed it
> the beer on the couch hack)
> What happens when you run a compiled with libnuma binary on a ARM
> target that doesn't have numa, as long as you don't supply the numa
> function?

I'm not sure if I understand your question.  But if I build with libnuma
then try to run it on a target that does not have the library, I get:

$ ./cyclictest_numa
./cyclictest_numa: error while loading shared libraries: libnuma.so.1: cannot open shared object file: No such file or directory

Which is not surprising, given:

$ ldd ./cyclictest_numa 
        librt.so.1 => /devel/lib/librt.so.1 (0xb6f4d000)
        libpthread.so.0 => /devel/lib/libpthread.so.0 (0xb6f2d000)
        libnuma.so.1 => not found
        libgcc_s.so.1 => /devel/usr/lib/libgcc_s.so.1 (0xb6f1a000)
        libc.so.6 => /devel/lib/libc.so.6 (0xb6de2000)
        /devel/lib/ld-linux.so.3 (0xb6f5c000)

-Frank

