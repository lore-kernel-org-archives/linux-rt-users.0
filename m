From: Joel Fernandes <joelf@ti.com>
Subject: Re: Ideas/suggestions to avoid repeated locking and reducing too
 many lists with dmaengine?
Date: Mon, 24 Feb 2014 16:53:33 -0600
Message-ID: <530BCD6D.9010208@ti.com>
References: <530B9784.5060904@ti.com> <20140224192152.GV27282@n2100.arm.linux.org.uk> <530BC9F8.2040402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	<linux-rt-users@vger.kernel.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <530BC9F8.2040402@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Correcting myself from an earlier post..

On 02/24/2014 04:38 PM, Joel Fernandes wrote:
>>>  Also with respect to virt_dma (which is used by edma to manage all the
>>> descriptors and lists) there are too many lists: submitted, issued,
>>> completed etc and the descriptor moves from one to the other. I am
>>> thinking if there is a way we can avoid using so many lists and just
>>> have 2 lists and move the desc from one list to the other, That could
>>> avoid using the intermediate list altogether and classify dma requests
>>> as "done" or "not done".
>>
>> The reason I created separate submitted and issued lists is that it's
>> much easier to manage than having everything on a single list.
>>
>> We could deal with the submitted vs issued list, and that's to have the
>> channel store the cookie for the last issued descriptor - but I wonder
>> if it's worth the effort.
>>
>> What I'd suggest is to try some profiling, and post some profiling
>> results which show where the problems are, rather than pointing at
>> bits of code you might not particularly like.
>>
> 
> Actually I did do some tracing earlier before I posted this thread- and
> notice there was excessive traces of locking/unlocking. It is very light
> though as you pointed and lighter without debug options. The only other
> notable difference is the fact that we are now going through the dmaengine
> framework in the newer kernel vs the faster one.
> 
> One more thing in my trace is omap_dma_sync repeatedly call in memcpy_to_io
> for every barrier call which is not necessary. I am working on a fix this.
> 
> On turning off DEBUG_KERNEL and running more tests, I do see some
> improvements however the throughput reduction is still =~ 10%
> 
> With a modified openssl speed test app, I sent 16-byte sized block
> repeatedly to the AES crypto hardware accelerator using EDMA:
> 
> On v3.13.5 kernel:
> root@am335x-evm:~# openssl speed -evp aes-128-cbc -engine cryptodev
> engine "cryptodev" set.
> Doing aes-128-cbc for 3s on 16 size blocks: 79902 aes-128-cbc's
> 
> With v3.2 kernel,
> Doing aes-128-cbc for 3s on 16 size blocks: 92314 aes-128-cbc's
> 
> So we're able to encrypt around 13k more ops, or around 4.5k ops/second
> with 3.13.5

We're able to encrypt around 13k more ops, or around 4.5k ops/second
with the older 3.2 kernel that didn't use DMAEngine.

Regards,
-Joel


