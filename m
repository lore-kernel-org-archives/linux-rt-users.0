From: Lionel DEBIEVE <lionel.debieve@st.com>
Subject: RE: [PATCH RT] tty: serial: st-asc: Make the locking RT aware
Date: Wed, 22 Mar 2017 16:14:28 +0000
Message-ID: <f4c07cb2241b46dd960b35ba1cd22f5b@SFHDAG7NODE2.st.com>
References: <1490112340-29772-1-git-send-email-lionel.debieve@st.com>
        <20170321144437.569440c2@vmware.local.home>
        <alpine.DEB.2.20.1703211950040.3776@nanos>
        <20170321161533.44c4df87@vmware.local.home>
        <99a6d117-4998-fe37-5e32-ef773597e8e9@st.com>
 <20170322091044.77df6f0c@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45570 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758940AbdCVQOm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Mar 2017 12:14:42 -0400
In-Reply-To: <20170322091044.77df6f0c@vmware.local.home>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

OK, resend without.
BR
Lionel

-----Original Message-----
From: Steven Rostedt [mailto:rostedt@goodmis.org] 
Sent: mercredi 22 mars 2017 17:11
To: Lionel DEBIEVE <lionel.debieve@st.com>
Cc: Thomas Gleixner <tglx@linutronix.de>; linux-rt-users@vger.kernel.org; linux-kernel@vger.kernel.org; bigeasy@linutronix.de; Patrice CHOTARD <patrice.chotard@st.com>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH RT] tty: serial: st-asc: Make the locking RT aware

On Wed, 22 Mar 2017 08:43:50 +0000
Lionel DEBIEVE <lionel.debieve@st.com> wrote:

> Just to agree with Thomas.
> 
> Do you want me to resend the patch without RT tag?
>

Yes please. And hopefully it will be picked up in mainline.

-- Steve
