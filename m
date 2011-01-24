From: "Madovsky" <infos@madovsky.org>
Subject: Re: Linearized 2.6.33.7-rt30 patch set available (with free coffee!)
Date: Mon, 24 Jan 2011 12:21:27 -0500
Message-ID: <EF7EFF0714E243509EDB7EC0CE571A8A@e1705>
References: <4D3DB025.9090502@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Thomas Gleixner" <tglx@linutronix.de>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ip-67-205-80-138.static.privatedns.com ([67.205.80.138]:34152
	"EHLO node250.e-blokos.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753152Ab1AXRVf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Jan 2011 12:21:35 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Nice metaphore Paul,

it explains well how sometimes a developer pain can be high
and hidden from users....

Regards

Franck

----- Original Message ----- 
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: <linux-rt-users@vger.kernel.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>
Sent: Monday, January 24, 2011 12:00 PM
Subject: Linearized 2.6.33.7-rt30 patch set available (with free coffee!)


> Some of you may be asking just what that means.
>
> The RT changes are like the milk added to a cup of coffee.  You add a
> small amount and it changes the flavour of the normal coffee (kernel.)
>
> Now imagine the nice waitress keeps adding more coffee to your cup,
> (merges) and you keep adding in a small splash of milk as well (new
> RT commits).  As time goes on, you kind of know what is in your coffee,
> but you'd have a hard time recreating an identical one from scratch,
> and you sure as heck can't take the milk *out* of your old coffee and
> move it to a new fresh cup of coffee.
>
> For most people, this is fine - they just want to drink the coffee,
> (i.e. RT users) and have no interest in the finer details of exactly
> how it was made.  But there are some people who do care, and for us,
> what this provides is the identical (line for line) v2.6.33.7.2-rt30
> source code, but with a clearer recipe of how it was created.
>
> Speaking more technically, the RT content in the tip git repo was
> originally based on 2.6.31, and then the newer kernel.org content
> was merged in.  Merge commits are not easy to review/digest, and if
> a functional change/addition was embedded in a merge commit, then
> you'll have a hard time seeing it at all, unless you explicitly go
> looking for it.
>
> So the goal was to have a linear, merge-free set of commits that are
> historically faithful to the original changes, but that stack on top
> of the current 2.6.33.7 baseline to give you the *exact* same source.
>
> Changes that were "hidden" in merge commits were either re-parented
> to an existing changeset, or extracted to be visible stand alone
> changesets in their own right -- depending on which made more sense.
>
> The result will be familiar with long time RT users, in that you get
> a series file, and a list of patches it applies, and you can use your
> tool of choice to apply them (git-am, quilt, git-quiltimport, etc.)
>
> Patches are in a git repo themselves, and you can find them here:
>
>  http://git.kernel.org/?p=linux/kernel/git/paulg/rt-patches.git
>
> If you scan backwards in the repo, you can get a sense of scale of
> what it took to (a) extract the original commits, then (b) make those
> apply, and then (c) resolve all the deltas between the new tree and
> the tip merge based tree. [I think (c) took more then (a)+(b) did!]
>
> Paul.
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 

