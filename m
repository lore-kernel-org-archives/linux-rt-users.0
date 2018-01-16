From: Bernhard Landauer <oberon@manjaro.org>
Subject: Re: [ANNOUNCE] 4.9.76-rt61
Date: Tue, 16 Jan 2018 23:11:32 +0000
Message-ID: <e61d28f2-446b-d00e-422e-e280378aadaf@manjaro.org>
References: <20180116180945.GU1153@jcartwri.amer.corp.natinst.com>
 <a481f2e6-0526-2296-76cf-4f0df6e27d41@manjaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Julia Cartwright <julia@ni.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Alex Shi <alex.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a481f2e6-0526-2296-76cf-4f0df6e27d41@manjaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Ah. Working now after adding in validpgpkeys array in the PKGBUILD.

Sorry.

B


On 16.01.2018 23:08, Bernhard Landauer wrote:
> Hi Julia.
> Seems I have a problem with your gpg key:
>
> unknown public key 8CDAC2E1454D746F
>
> $ gpg --receive-key 8CDAC2E1454D746F
> gpg: key 0A120DD923EEDD5F: 9 signatures not checked due to missing keys
> gpg: key 0A120DD923EEDD5F: public key "Julia J. Cartwright (Julia
> Cartwright) <juliac@eso.teric.us>" imported
> gpg: marginals needed: 3  completes needed: 1  trust model: pgp
> gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
> gpg: Total number processed: 1
> gpg:               imported: 1
>
> ==> Verifying source file signatures with gpg...
>     patch-4.9.76-rt61.patch ... FAILED (invalid public key
> 2B82682463E46862339A88A90A120DD923EEDD5F)
>
> regards
> Bernhard
>
> On 16.01.2018 18:09, Julia Cartwright wrote:
>> Hello RT Folks!
>>
>> I'm pleased to announce the 4.9.76-rt61 stable release.
>>
>> This release is just an update to the new stable 4.9.76 version
>> and no RT specific changes have been made.
>>
>> You can get this release via the git tree at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>>
>>   branch: v4.9-rt
>>   Head SHA1: 90816cc1d4a1d23efe37b74866c6174dd5eab6b5
>>
>> Or to build 4.9.76-rt61 directly, the following patches should be applied:
>>
>>   http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz
>>
>>   http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.76.xz
>>
>>   http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.76-rt61.patch.xz
>>
>> You can get this release via the git tree at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>>
>>   branch: v4.9-rt
>>   Head SHA1: 90816cc1d4a1d23efe37b74866c6174dd5eab6b5
>>
>> Or to build 4.9.76-rt61 directly, the following patches should be applied:
>>
>>   http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz
>>
>>   http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.76.xz
>>
>>   http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.76-rt61.patch.xz
>>
>> Enjoy,
>>    Julia
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
