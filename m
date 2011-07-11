From: jordan <triplesquarednine@gmail.com>
Subject: Re: State of Linux-RT Patches and full inclusion into linus tree
Date: Mon, 11 Jul 2011 01:43:58 -0400
Message-ID: <CAOcfFMx6ULXTgZLKU7gi=oRd0OEyqpRFi-u+Ud3SX-kRXnGnpQ@mail.gmail.com>
References: <1449505.pSCLrkaxpL@segfault.sh0n.net>
	<CAF_S4t_Q1gMnP+mfM+XGPjJYG_jNPwXhY1557bkZPC9c=mS-xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shawn Starr <shawn.starr@rogers.com>, linux-kernel@vger.kernel.org,
	RT <linux-rt-users@vger.kernel.org>
To: Bryan Donlan <bdonlan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAF_S4t_Q1gMnP+mfM+XGPjJYG_jNPwXhY1557bkZPC9c=mS-xg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jul 11, 2011 at 12:46 AM, Bryan Donlan <bdonlan@gmail.com> wrote:
> On Sun, Jul 10, 2011 at 20:43, Shawn Starr <shawn.starr@rogers.com> wrote:
>> Hello,
>>
>> I was wondering if (or ever) will the full Linux RT patches be merged into
>> Linus's tree? If not, what is preventing this? I know bits of this has been
>> leaking into 2.6.x over the years.

One of the key parts of the RT patchset, is already mainline - and was
merged in 2.6.39. - Forced Interrupt Threading. it can be enabled in
the kernel config. From what i understand there are other bits and
pieces to the RT patchset. But this was the most significant.. it is
certainly mainline and has been available for quite a while now. I am
typing from a computer that has it enabled, as i write to you now.

myself, i used RT for proaudio ~ i do not require RT anymore, at all.
my applications always meet their 'deadlines' with very low-latency
and work the way they are supposed too.

someone else can clarify on the bits of RT are still to be merged, as
i don't know. i just remember someone talking about that a few months
ago on the list. maybe that has changed. I had also read there was
supposed to be another RT release, but your posting is the first on
this list in a long time.

jordan
