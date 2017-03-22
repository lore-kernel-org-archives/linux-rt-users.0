From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] tty: serial: st-asc: Make the locking RT aware
Date: Wed, 22 Mar 2017 09:10:44 -0700
Message-ID: <20170322091044.77df6f0c@vmware.local.home>
References: <1490112340-29772-1-git-send-email-lionel.debieve@st.com>
        <20170321144437.569440c2@vmware.local.home>
        <alpine.DEB.2.20.1703211950040.3776@nanos>
        <20170321161533.44c4df87@vmware.local.home>
        <99a6d117-4998-fe37-5e32-ef773597e8e9@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
To: Lionel DEBIEVE <lionel.debieve@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <99a6d117-4998-fe37-5e32-ef773597e8e9@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 22 Mar 2017 08:43:50 +0000
Lionel DEBIEVE <lionel.debieve@st.com> wrote:

> Just to agree with Thomas.
> 
> Do you want me to resend the patch without RT tag?
>

Yes please. And hopefully it will be picked up in mainline.

-- Steve
