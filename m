From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Linearized 2.6.33.7-rt30 patch set available (with free coffee!)
Date: Mon, 31 Jan 2011 18:35:18 -0500
Message-ID: <4D474736.40703@windriver.com>
References: <4D47242E.1000508@am.sony.com> <4D4725CF.6060008@windriver.com> <4D473046.8090009@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:46041 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083Ab1AaXf1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Jan 2011 18:35:27 -0500
In-Reply-To: <4D473046.8090009@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11-01-31 04:57 PM, Frank Rowand wrote:
> On 01/31/11 13:12, Paul Gortmaker wrote:
>> On 11-01-31 04:05 PM, Frank Rowand wrote:
>>> Hi Paul,
>>>
>>> Thanks for the patch set!  I had started down the path of doing
>>> the same work, and truly appreciate the effort you put into this.
>>>
>>> One of the patches had a chunk that failed to apply:
>>>
>>> genirq-support-forced-threading-of-interrupts.patch
>>
>> Interesting.  I was using "git am" to apply them, and I can assure
>> you that they all applied with that (which is quite strict in its
>> checking.)
>>
>> What were you applying them with?
> 
> quilt push -a

OK, so it is simply a matter of quilt dying while git am is capable
of doing the right thing (see below for evidence).  I'll re-export all
the patches on the v2.6.33-rt branch, which will fix you up.  Should
be able to do that shortly -- check the gitweb page for activity on
the v2.6.33-rt branch, which is what you want to use.

You do realize that by using quilt though, that you are throwing away
all the commit headers and the history, which is the whole point of
this tree existing?   You are just building up the original RT giant
diff one chunk at a time.  Unless you are thinking or intending to
insert some other SCM into the quilt processing at each step, I don't
see the point of using quilt and doing a "push -a"

Assuming you aren't doing this for integration with another SCM,
if you simply replace quilt with something as simple as this $0.02
script, you will keep the history intact:

----------------------------------------
#!/bin/bash
SERIES=$1

if [ -z "$SERIES" ]; then
        echo need a series file
        exit 1
fi

DIR=`dirname $SERIES`

for i in `cat $SERIES | grep '^[a-zA-Z0-9_]'`
do
        git am $DIR/$i
        if [ $? != 0 ];then
                echo git am of $i failed. STBU.
                exit 1
        fi
done
----------------------------------------------------

The above is essentially a dumbed-down version of git quiltimport
(i.e. no possibility of author or subject munging.)

There is also "guilt", which is essentially quilt, but with a git
commit for each changeset -- something you might want to evaluate
for your own needs.

Paul.

---

tip-debare$git checkout quilt-junk 
Switched to branch 'quilt-junk'
tip-debare$git am patches/genirq-support-forced-threading-of-interrupts.patch
Applying: genirq: support forced threading of interrupts

(git am is happy, now rewind/pop that commit and retry with quilt)

tip-debare$git reset --hard HEAD^
HEAD is now at fd659fd7 quilt-junk
tip-debare$quilt push
Applying patch genirq-support-forced-threading-of-interrupts.patch
patching file include/linux/interrupt.h
patching file include/linux/irq.h
patching file include/linux/sched.h
patching file kernel/irq/chip.c
patching file kernel/irq/handle.c
patching file kernel/irq/manage.c
Hunk #2 succeeded at 465 (offset 3 lines).
Hunk #3 succeeded at 633 (offset 3 lines).
Hunk #4 succeeded at 706 (offset 3 lines).
Hunk #5 succeeded at 736 (offset 3 lines).
Hunk #6 succeeded at 804 (offset 3 lines).
Hunk #7 FAILED at 829.
1 out of 7 hunks FAILED -- rejects in file kernel/irq/manage.c
patching file kernel/irq/migration.c
patching file kernel/sched.c
Hunk #1 succeeded at 5147 (offset 3 lines).
Patch genirq-support-forced-threading-of-interrupts.patch does not apply (enforce with -f)
tip-debare$




