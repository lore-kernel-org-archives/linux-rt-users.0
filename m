From: Mark Knecht <markknecht@gmail.com>
Subject: Arm me with info - root != real-time
Date: Mon, 23 Feb 2009 14:29:37 -0800
Message-ID: <5bdc1c8b0902231429r320efb5by507f3cb26c2d5162@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:47777 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbZBWW3k (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Feb 2009 17:29:40 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2134677rvb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Feb 2009 14:29:37 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Ingo, Steven, Thomas and other RT developers,
  As always, thanks for what you do. I've been subscribed here for a
few years. Don't say much. Do read a lot.

   As a user type I've run the RT kernels for years now. 5 years ago
it was really crucial for my music work. I still use it faithfully.
However on many lists now I'm seeing new people say there's no need
for the RT kernel because they run their applications as root and feel
they get the 'same' or 'good enough' results. I wonder how they know
if they don't run both and compare but that's their business. I'm
suspect but not technically deep enough in this subject to have a
conversation so I thought I'd ask for a little simple (if possible)
education.

I PROCLAIM - Running an application as root on the standard kernel is
not as real time capable as running the same application as a normal
user with proper priorities & permissions on the RT kernel.

True or false?

   Is there a source of measured data to show this is true or false?

   I know a lot of what you've done over the years is now mainline but
I don't know how much of it is turned on by default.

   Clearly, I think folks don't have their head screwed on tight if
they are running development apps as root, but people are doing it.
They don't seem to care about security or the obvious fact that
running as root might allow an app to erase their hard drive, etc.
Their minds will change when something goes wrong, but in the meantime
what can I tell them about this subject to get them to use the RT
kernel and be as happy as I am with it.

Thanks,
Mark
