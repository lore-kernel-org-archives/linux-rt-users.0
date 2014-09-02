From: Juri Lelli <juri.lelli@gmail.com>
Subject: Re: set_schedattr + cpuset issue
Date: Tue, 2 Sep 2014 11:36:08 +0100
Message-ID: <CAE-h8tG6VCG0oX=AsPA-jKGqC=FheJD=4awByMukkUgD4uOUDg@mail.gmail.com>
References: <CAMLzMweCcxPBJExGsY-2oHK6sdF6EVgBsa1XVxQT0=kzNRZAJQ@mail.gmail.com>
	<20140710122033.58bdd366fe3f869a71b1c05e@gmail.com>
	<871ts0s4pn.fsf@cecht.legt.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c347e0f9d95c050212af35
Cc: Kevin Burns <kevinpb@vt.edu>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	juri.lelli@arm.com
To: Vincent Legout <vincent@legout.info>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34110 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbaIBKgK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Sep 2014 06:36:10 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so14051945wib.9
        for <linux-rt-users@vger.kernel.org>; Tue, 02 Sep 2014 03:36:08 -0700 (PDT)
In-Reply-To: <871ts0s4pn.fsf@cecht.legt.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--001a11c347e0f9d95c050212af35
Content-Type: text/plain; charset=UTF-8

Hi Vincent and Kevin,

thanks a lot for your report. I was also actually experiencing something that I
think is related to your issue, but then I didn't find any time to send out
a proper patch :/.

Could you please test what I've attached and see if it fixes your problem?

Thanks a lot,

- Juri

On 28 August 2014 22:07, Vincent Legout <vincent@legout.info> wrote:
> Hello,
>
> Juri Lelli <juri.lelli@gmail.com> writes:
>
>> On Wed, 2 Jul 2014 17:08:47 -0400
>> Kevin Burns <kevinpb@vt.edu> wrote:
>>
>>> Here's the issue:
>>>
>>> I am able to allocate a bandwidth with a ratio of .1 to two processes using
>>> the sched_setattr() system call.
>>>
>>> I then am able to add said tasks to a cpuset (with one physical processor)
>>> using cset.
>>>
>>> However, when I then try to update the runtime or period of either task,
>>> sched_setattr returns a -EBUSY error.
>>>
>>> Now, if I repeat the above experiment with just one task, I am able to
>>> update the runtime or period without issue. I ran trace-cmd and kernelshark
>>> to verify that the bandwidths were indeed being updated correctly. That and
>>> htop was reporting a higher percentage of CPUusage, which correlated to the
>>> ratios of my task's bandwidth.
>>>
>>> Any ideas as to why cpuset would cause this behaviour?
>>>
>>
>> Could you create a script that I can use to run your setup and reproduce
>> the problem?
>
> Sorry for the delayed answer. I'm working with Kevin and the problem can
> be reproduced using the attached files, also available here:
>
>  http://legout.info/~vincent/sd/
>
> On a Ubuntu 14.04 system running Linux 3.16, when running run.sh for the
> 2nd time, the 2nd call to sched_setattr() returns EBUSY. Uncommenting
> line 41 of run.sh fixes this by returning to SCHED_OTHER before moving
> the task to the cpuset.
>
> The problem arises when using both cpusets and SCHED_DEADLINE. The
> process described in section 5.1 of the SCHED_DEADLINE documentation
> works fine if the process stays on the same cpuset, but I think their
> are some issues when moving a process already in the SCHED_DEADLINE
> policy from one cpuset to another.
>
> According to our experiments, it seems that some fields are not updated
> during this process, and it thus fails. When a task moves from one
> cpuset to another, the total_bw fields of both cpusets doesn't seem to
> be updated. Thus, in the next sched_setattr() call, __dl_overflow()
> returns 1 because it thinks total_bw is 0 in the new cpuset. Then,
> dl_overflow() returns -1 and we have a EBUSY error.
>
> The total_bw field may also overflow because __dl_clear and __dl_add are
> called while the task whose bandwidth is tsk_bw is not in the cpu
> represented by dl_b.
>
> We can get around this by moving the process back to another scheduling
> policy before moving it to another cpuset. But we also had to apply the
> following patch in order to be sure that the bandwith is always updated
> (on top of v3.16). I'd think this condition has been added to skip all
> the tests if the bandwith doesn't change. But there is an issue because
> then, the total_bw field is not going to be updated for the new cpu. I'd
> think the problem comes from the fact that p->dl.dl_bw is not updated
> when a task leaves or returns the SCHED_DEADLINE policy.
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bc1638b..0df3008 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2031,9 +2031,6 @@ static int dl_overflow(struct task_struct *p, int policy,
>         u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
>         int cpus, err = -1;
>
> -       if (new_bw == p->dl.dl_bw)
> -               return 0;
> -
>         /*
>          * Either if a task, enters, leave, or stays -deadline but changes
>          * its parameters, we may need to update accordingly the total
>
> I hope the above explanations make sense and I didn't miss anything
> trivial. I'd be happy to provide more information or test anything if
> needed.
>
> Thanks,
> Vincent
>

--001a11c347e0f9d95c050212af35
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-sched-deadline-clear-dl_entity-params-when-setschedu.patch"
Content-Disposition: attachment;
	filename="0001-sched-deadline-clear-dl_entity-params-when-setschedu.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hzl3mjlz0

RnJvbSAyMjQzZDI1ZmJmMGRmMTEyYTgzYzEyY2E4YTA1ZTQzODRlYTE3MDU4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdXJpIExlbGxpIDxqdXJpLmxlbGxpQGFybS5jb20+CkRhdGU6
IFdlZCwgMTEgSnVuIDIwMTQgMTY6Mzc6MzEgKzAyMDAKU3ViamVjdDogW1BBVENIXSBzY2hlZC9k
ZWFkbGluZTogY2xlYXIgZGxfZW50aXR5IHBhcmFtcyB3aGVuIHNldHNjaGVkdWxpbmcgdG8KIGRp
ZmZlcmVudCBjbGFzcwoKV2hlbiBhIHRhc2sgaXMgdXNpbmcgU0NIRURfREVBRExJTkUgYW5kIHRo
ZSB1c2VyIHNldHNjaGVkdWxlcyBpdCB0byBhIGRpZmZlcmVudApjbGFzcyBpdHMgc2NoZWRfZGxf
ZW50aXR5IHN0YXRpYyBwYXJhbWV0ZXJzIGFyZSBub3QgY2xlYW5lZCB1cC4gVGhpcyBjYXVzZXMg
YQpidWcgaWYgdGhlIHVzZXIgc2V0cyBpdCBiYWNrIHRvIFNDSEVEX0RFQURMSU5FIHdpdGggdGhl
IHNhbWUgcGFyYW1ldGVycyBhZ2Fpbi4KVGhlIHByb2JsZW0gcmVzaWRlcyBpbiB0aGUgY2hlY2sg
d2UgcGVyZm9ybSBhdCB0aGUgdmVyeSBiZWdpbm5pbmcgb2YKZGxfb3ZlcmZsb3coKToKCglpZiAo
bmV3X2J3ID09IHAtPmRsLmRsX2J3KQoJCXJldHVybiAwOwoKVGhpcyBjb25kaXRpb24gaXMgbWV0
IGluIHRoZSBjYXNlIGRlcGljdGVkIGFib3ZlLCBzbyB0aGUgZnVuY3Rpb24gcmV0dXJucyBhbmQK
ZGxfYi0+dG90YWxfYncgaXMgbm90IHVwZGF0ZWQgKHRoZSBwLT5kbC5kbF9idyBpcyBub3QgYWRk
ZWQgdG8gaXQpLiBBZnRlciB0aGlzLAphZG1pc3Npb24gY29udHJvbCBpcyBicm9rZW4uCgpUaGlz
IHBhdGNoIGZpeGVzIHRoZSB0aGluZywgcHJvcGVybHkgY2xlYXJpbmcgc3RhdGljIHBhcmFtZXRl
cnMgZm9yIGEgdGFzawp0aGF0IGNlYXNlcyB0byB1c2UgU0NIRURfREVBRExJTkUuCgpSZXBvcnRl
ZC1ieTogRGFuaWVsZSBBbGVzc2FuZHJlbGxpIDxkYW5pZWxlLmFsZXNzYW5kcmVsbGlAZ21haWwu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBKdXJpIExlbGxpIDxqdXJpLmxlbGxpQGFybS5jb20+CkNjOiBJ
bmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT4KQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpA
aW5mcmFkZWFkLm9yZz4KQ2M6IEp1cmkgTGVsbGkgPGp1cmkubGVsbGlAZ21haWwuY29tPgpDYzog
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwotLS0KIGtlcm5lbC9zY2hlZC9jb3JlLmMgfCAy
MSArKysrKysrKysrKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9jb3JlLmMgYi9rZXJu
ZWwvc2NoZWQvY29yZS5jCmluZGV4IGVjMWEyODYuLjAxNzM4YjIgMTAwNjQ0Ci0tLSBhL2tlcm5l
bC9zY2hlZC9jb3JlLmMKKysrIGIva2VybmVsL3NjaGVkL2NvcmUuYwpAQCAtMTc3Niw2ICsxNzc2
LDIxIEBAIGludCB3YWtlX3VwX3N0YXRlKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwgdW5zaWduZWQg
aW50IHN0YXRlKQogfQogCiAvKgorICogVGhpcyBmdW5jdGlvbiBjbGVhcnMgdGhlIHNjaGVkX2Rs
X2VudGl0eSBzdGF0aWMgcGFyYW1zLgorICovCitzdGF0aWMgdm9pZAorX19kbF9jbGVhcl9wYXJh
bXMoc3RydWN0IHRhc2tfc3RydWN0ICpwKQoreworCXN0cnVjdCBzY2hlZF9kbF9lbnRpdHkgKmRs
X3NlID0gJnAtPmRsOworCisJZGxfc2UtPmRsX3J1bnRpbWUgPSAwOworCWRsX3NlLT5kbF9kZWFk
bGluZSA9IDA7CisJZGxfc2UtPmRsX3BlcmlvZCA9IDA7CisJZGxfc2UtPmZsYWdzID0gMDsKKwlk
bF9zZS0+ZGxfYncgPSAwOworfQorCisvKgogICogUGVyZm9ybSBzY2hlZHVsZXIgcmVsYXRlZCBz
ZXR1cCBmb3IgYSBuZXdseSBmb3JrZWQgcHJvY2VzcyBwLgogICogcCBpcyBmb3JrZWQgYnkgY3Vy
cmVudC4KICAqCkBAIC0xNzk5LDEwICsxODE0LDcgQEAgc3RhdGljIHZvaWQgX19zY2hlZF9mb3Jr
KHVuc2lnbmVkIGxvbmcgY2xvbmVfZmxhZ3MsIHN0cnVjdCB0YXNrX3N0cnVjdCAqcCkKIAogCVJC
X0NMRUFSX05PREUoJnAtPmRsLnJiX25vZGUpOwogCWhydGltZXJfaW5pdCgmcC0+ZGwuZGxfdGlt
ZXIsIENMT0NLX01PTk9UT05JQywgSFJUSU1FUl9NT0RFX1JFTCk7Ci0JcC0+ZGwuZGxfcnVudGlt
ZSA9IHAtPmRsLnJ1bnRpbWUgPSAwOwotCXAtPmRsLmRsX2RlYWRsaW5lID0gcC0+ZGwuZGVhZGxp
bmUgPSAwOwotCXAtPmRsLmRsX3BlcmlvZCA9IDA7Ci0JcC0+ZGwuZmxhZ3MgPSAwOworCV9fZGxf
Y2xlYXJfcGFyYW1zKHApOwogCiAJSU5JVF9MSVNUX0hFQUQoJnAtPnJ0LnJ1bl9saXN0KTsKIApA
QCAtMjA2MCw2ICsyMDcyLDcgQEAgc3RhdGljIGludCBkbF9vdmVyZmxvdyhzdHJ1Y3QgdGFza19z
dHJ1Y3QgKnAsIGludCBwb2xpY3ksCiAJCWVyciA9IDA7CiAJfSBlbHNlIGlmICghZGxfcG9saWN5
KHBvbGljeSkgJiYgdGFza19oYXNfZGxfcG9saWN5KHApKSB7CiAJCV9fZGxfY2xlYXIoZGxfYiwg
cC0+ZGwuZGxfYncpOworCQlfX2RsX2NsZWFyX3BhcmFtcyhwKTsKIAkJZXJyID0gMDsKIAl9CiAJ
cmF3X3NwaW5fdW5sb2NrKCZkbF9iLT5sb2NrKTsKLS0gCjIuMC40Cgo=
--001a11c347e0f9d95c050212af35--
