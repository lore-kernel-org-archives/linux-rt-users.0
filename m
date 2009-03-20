From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [Announce] 2.6.29-rc78rt1
Date: Fri, 20 Mar 2009 14:55:26 -0700
Message-ID: <49C410CE.8070204@am.sony.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain> <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain> <alpine.LFD.2.00.0902231854360.3523@localhost.localdomain> <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain> <alpine <49C2F37B.3030909@am.sony.com> <alpine.LFD.2.00.0903201645400.29264@localhost.localdomain>
Reply-To: frank.rowand@am.sony.com
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa4ehsobe003.messaging.microsoft.com ([216.32.181.13]:14112
	"EHLO WA4EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751435AbZCTWLQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Mar 2009 18:11:16 -0400
In-Reply-To: <alpine.LFD.2.00.0903201645400.29264@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner wrote:
> On Thu, 19 Mar 2009, Frank Rowand wrote:
>>>    - lots of tracer updates from -tip (check the tip git logs)
>> I have been trying to reverse engineer which git commits
>> comprise origin.patch, but my git-foo is not up to the
>> task.  For any single file in origin.patch, I can work
>> backwards to find the git commit associated with it, but I
>> don't know how to easily create a list of all of the git commits
>> that are associated with origin.patch.  Do you have any quick
>> hints that would assist me in my quest?
> 
>   git log v.2.6.29-rc8..
> 
> I'm going to add a log to the broken out tarball next time.
> 

Thanks for the info!  I'm getting closer, but I'm still missing
something or doing something wrong.

The git tree I'm using (from .git/config):
[remote "origin"]
        url = git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git

On branch "master".

I tried to re-create origin.patch by:

  git format-patch --abbrev=7 --stdout -p v2.6.29-rc8.. >MY_ORIGIN.PATCH

but got different results than what is in origin.patch.bz.
MY_ORIGIN.PATCH has the same source changes as origin.patch.bz
(at least for the small sample of files that I checked), but
sometimes split across several patches instead of a single patch.

Using Documentation/x86/boot.txt as an example of the difference:

  patch-2.6.29-rc8-rt1-broken-out.tar.bz2 origin.patch.bz shows:

    diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
    index 7b4596a..e020366 100644

  But the same changes in the git tree are split across two git commits
  (so I get two patches in my MY_ORIGIN.PATCH instead of the single
  patch in origin.patch.bz):

    $ git log v2.6.29-rc8.. -- Documentation/x86/boot.txt | grep commit
    commit 8b0e5860cb099d7958d13b00ffbc35ad02735700
    commit e56d0cfe7790fd3218ae4f6aae1335547fea8763
    commit ee287587dafd77fd211e50637561224605c214b4

    (8b0e5860 is a merge of branches)

    $ git format-patch --abbrev=7 --stdout -p e56d0cfe^1..e56d0cfe \
      | grep -E "(^diff)|(^index)"
    diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
    index 7b4596a..1229969 100644

    $ git format-patch --abbrev=7 --stdout -p ee287587^1..ee287587 \
      | grep -E "(^diff)|(^index)"
    diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
    index fcdc62b..9ac70ff 100644

  So I'm obviously in the wrong place or using the wrong technique
  to be able to re-create origin.patch.bz from the git repository.
  Any more quick hints to help me out here?

  Also, "git log v2.6.29-rc8.." presumes that HEAD in my repository is
  the same as when the RT preempt patch was created.  Is there a tag
  or a git id or some other way to identify that point?

Thanks!

Frank Rowand
Sony Corporation of America

