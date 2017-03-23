From: Patrice CHOTARD <patrice.chotard@st.com>
Subject: Re: [PATCH 1/1] tty: serial: st-asc: Make the locking RT aware
Date: Thu, 23 Mar 2017 07:56:27 +0000
Message-ID: <d592cad0-1509-4eec-1012-7af17f9e577c@st.com>
References: <1490202751-16581-1-git-send-email-lionel.debieve@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Lionel DEBIEVE <lionel.debieve@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490202751-16581-1-git-send-email-lionel.debieve@st.com>
Content-Language: en-US
Content-ID: <39AE01551037084B8D4FD5D8BD671354@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Lionel

On 03/22/2017 06:12 PM, Lionel Debieve wrote:
> The lock is a sleeping lock and local_irq_save() is not the
> standard implementation now. Working for both -RT and non
> RT.
>
> Signed-off-by: Lionel Debieve <lionel.debieve@st.com>

Acked-by: Patrice Chotard <patrice.chotard@st.com>


> ---
>  drivers/tty/serial/st-asc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index c334bcc..4889396 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -887,13 +887,12 @@ static void asc_console_write(struct console *co, const char *s, unsigned count)
>  	int locked = 1;
>  	u32 intenable;
>
> -	local_irq_save(flags);
>  	if (port->sysrq)
>  		locked = 0; /* asc_interrupt has already claimed the lock */
>  	else if (oops_in_progress)
> -		locked = spin_trylock(&port->lock);
> +		locked = spin_trylock_irqsave(&port->lock, flags);
>  	else
> -		spin_lock(&port->lock);
> +		spin_lock_irqsave(&port->lock, flags);
>
>  	/*
>  	 * Disable interrupts so we don't get the IRQ line bouncing
> @@ -911,8 +910,7 @@ static void asc_console_write(struct console *co, const char *s, unsigned count)
>  	asc_out(port, ASC_INTEN, intenable);
>
>  	if (locked)
> -		spin_unlock(&port->lock);
> -	local_irq_restore(flags);
> +		spin_unlock_irqrestore(&port->lock, flags);
>  }
>
>  static int asc_console_setup(struct console *co, char *options)
>
