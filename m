From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: [PATCH 1/1] tty: serial: st-asc: Make the locking RT aware
Date: Wed, 29 Mar 2017 18:10:40 +0200
Message-ID: <20170329161040.ktv4qpiyhjfjzdss@linutronix.de>
References: <1490202751-16581-1-git-send-email-lionel.debieve@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrice Chotard <patrice.chotard@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org
To: Lionel Debieve <lionel.debieve@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1490202751-16581-1-git-send-email-lionel.debieve@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-03-22 18:12:31 [+0100], Lionel Debieve wrote:
> The lock is a sleeping lock and local_irq_save() is not the
> standard implementation now. Working for both -RT and non
> RT.
> 
> Signed-off-by: Lionel Debieve <lionel.debieve@st.com>

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This is how serial8250_console_write() looks upstream, too.

Sebastian
