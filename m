From: Shane <gnome42@gmail.com>
Subject: Re: [PATCH RT] fix migrating softirq [cause of network hang]
Date: Wed, 13 Jun 2007 18:20:33 -0400
Message-ID: <fa4052ef0706131520x619ff3f5ke23cf649b8ff2b79@mail.gmail.com>
References: <fa4052ef0706131414o27b2281bp81d3f5b3d3104f87@mail.gmail.com>
	 <Pine.LNX.4.58.0706131723430.20636@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	mingo@elte.hu
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758213AbXFMWVF@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0706131723430.20636@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 6/13/07, Steven Rostedt <rostedt@goodmis.org> wrote:
> > I have applied this patch to 2.6.21.4-rt13 and I think it might have
> > solved my bizarre nfs hangage issues that cropped up lately. Thanks
> > for tracking that down it was driving me nutz!
> >
> > It has only been a few hours, but if you don't hear back from me in
> > the next day or so then it's good to go IMVHO. :)
> >
>
> Hi Shane,
>
> That's great to hear!  Well, if it does go well, could you post to LKML
> and linux-rt mailing lists, as well as CC'ng Ingo. Good news like this
> should be shared ;-)
>
> Heh, even if it doesn't go well, you can post to the above too.

Heh, I spoke too soon. This patch doesn't seem to help my problem after all. :/

Shane
