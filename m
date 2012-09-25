From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: Re: [PATCH] tty: cleanup duplicate functions in tty_buffer
Date: Tue, 25 Sep 2012 13:28:35 +0200
Message-ID: <CAMSQXEFoJa++iWqyx2v44CPDO1FXvt8y=MaUgV20bH337Ard8g@mail.gmail.com>
References: <1348149223-4281-1-git-send-email-meltedpianoman@gmail.com>
	<20120920171717.04ee9098@bob.linux.org.uk>
	<CAMSQXEHkjWubwNXiCd_bBnUdzQ2M+sa8HPs2KCzwcOOp2dSsBw@mail.gmail.com>
	<20120924102547.62581af4@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>,
	Jiri Slaby <jslaby@suse.cz>,
	Heiko Carstens <heiko.carstens@de.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120924102547.62581af4@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi

2012/9/24 Alan Cox <alan@lxorguk.ukuu.org.uk>:
>
> flush_to_ldisc calls into the tty core code which sleeps. The rule is
> that you may not call flush_to_ldisc except from a workqueue context.
>
> If you break that rule then various bad things will occur (eg rx ->
> flush_to_ldisc -> n_tty -> flow control -> tx -> deadlock) in a lot of
> drivers.
>
>
> Several of them are ones that shouldn't.
>

OK, I now understand what you mean with "pile that has needs to move
the other way"
I'll abandon this patch.

Thank you all for reviewing

Regards,
Ivo Sieben
