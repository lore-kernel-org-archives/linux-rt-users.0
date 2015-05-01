From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFD 0/5] Add latency histogram
Date: Fri, 01 May 2015 09:22:46 +0000
Message-ID: <554345E6.7040005@monom.org>
References: <1430388385-29558-1-git-send-email-daniel.wagner@bmw-carit.de> <1430445124.17922.12.camel@picadillo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Carsten Emde <C.Emde@osadl.org>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Tom Zanussi <tom.zanussi@linux.intel.com>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430445124.17922.12.camel@picadillo>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Tom,

On 05/01/2015 01:52 AM, Tom Zanussi wrote:
> Hi Daniel,
>
> On Thu, 2015-04-30 at 12:06 +0200, Daniel Wagner wrote:
>> Hi,
>>
>> I would like to discuss a possible way of getting the feature of the
>> latecy_hist.patch [1] added to mainline.
>>
>> "Latency histograms are primarily relevant in the context of real-time
>> enabled kernels (CONFIG_PREEMPT/CONFIG_PREEMPT_RT)and are used in the
>> quality management of the Linux real-time capabilities."
>>
>> Steven pointed out that this might be doable based on Tom Zanussi's
>> "[PATCH v4 0/7] tracing: 'hist' triggers" [2].
>>
>> Here are my findings. It was not too complicated to get it working,
>> though I had to add some hacks. I have added comments to each patch.
>>
>
> It looks like you were able to do quite a bit here with not much code -
> nice!

Thanks :)

> Just FYI, I'll be working on a v5 of the hist triggers patchset that
> will incorporate the stuff from patch 1 (needs to be split into a
> separate patch for the triggers code already upstream, and one for hist
> triggers) and your comments from patch 2 (see comments in my reply to
> that patch), along with  a couple other unrelated changes...

Great to hear!

cheers,
daniel
