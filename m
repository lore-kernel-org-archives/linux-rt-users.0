From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4] perf-probe: Support escaped character in parser
Date: Sat, 16 Dec 2017 23:52:05 +0900
Message-ID: <20171216235205.173fab04c2b13abadf7497ac@kernel.org>
References: <151309111236.18107.5634753157435343410.stgit@devbox>
        <20171212152724.GO3958@kernel.org>
        <20171213224024.f4d4e5dde81582f80b132be3@kernel.org>
        <20171213154227.GC9490@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bhargavb <bhargavaramudu@gmail.com>, linux-kernel@vger.kernel.org,
        Paul Clarke <pc@us.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        linux-rt-users@vger.kernel.org, linux-perf-users@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <20171213154227.GC9490@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 13 Dec 2017 12:42:27 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Wed, Dec 13, 2017 at 10:40:24PM +0900, Masami Hiramatsu escreveu:
> > On Tue, 12 Dec 2017 12:27:24 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > > Em Wed, Dec 13, 2017 at 12:05:12AM +0900, Masami Hiramatsu escreveu:
> > > > Support the special characters escaped by '\' in parser.
> > > > This allows user to specify versions directly like below.
> > > > 
> > > >   =====
> > > >   # ./perf probe -x /lib64/libc-2.25.so malloc_get_state\\@GLIBC_2.2.5
> > > >   Added new event:
> > > >     probe_libc:malloc_get_state (on malloc_get_state@GLIBC_2.2.5 in /usr/lib64/libc-2.25.so)
> > > > 
> > > >   You can now use it in all perf tools, such as:
> > > > 
> > > > 	  perf record -e probe_libc:malloc_get_state -aR sleep 1
> > > > 
> > > >   =====
> > > > 
> > > > Or, you can use separators in source filename, e.g.
> > > > 
> > > >   =====
> > > >   # ./perf probe -x /opt/test/a.out foo+bar.c:3
> > > >   Semantic error :There is non-digit character in offset.
> > > >     Error: Command Parse Error.
> > > >   =====
> > > > 
> > > > Usually "+" in source file cause parser error, but
> > > > 
> > > >   =====
> > > >   # ./perf probe -x /opt/test/a.out foo\\+bar.c:4
> > > >   Added new event:
> > > >     probe_a:main         (on @foo+bar.c:4 in /opt/test/a.out)
> > > > 
> > > >   You can now use it in all perf tools, such as:
> > > > 
> > > > 	  perf record -e probe_a:main -aR sleep 1
> > > >   =====
> > > > 
> > > > escaped "\+" allows you to specify that.
> > > 
> > > <SNIP>
> > >  
> > > >  Changes in v4:
> > > >   - Fix a build error (Thanks for Arnaldo!)
> > > >     This time, I ensured that I ran "make build-test" and it passed.
> > > 
> > > Thanks, testing it I still have that artifact:
> > > 
> > >  ---------------------------------------
> > > 
> > > [root@jouet perf]# perf probe -x /lib64/libc-2.25.so malloc_get_state\\@GLIBC_2.2.5
> > > Added new event:
> > >   probe_libc:malloc_get_state (on malloc_get_state@GLIBC_2.2.5 in /usr/lib64/libc-2.25.so)
> > > 
> > > You can now use it in all perf tools, such as:
> > > 
> > > 	perf record -e probe_libc:malloc_get_state -aR sleep 1
> > > 
> > > [root@jouet perf]# perf probe -l
> > > Failed to find debug information for address dd38eca7
> > >   probe_libc:malloc_get_state (on 0xdd38eca7 in /usr/lib64/libc-2.25.so)
> > > [root@jouet perf]#
> > > 
> > >  ---------------------------------------
> > > 
> > > I mean the "on 0xdd38eca7" part:
> > > 
> > > 
> > > That failed to find debug information part:
> > > 
> > > [root@jouet perf]# perf probe -vv -l
> > > Add filter: *
> > > Opening /sys/kernel/debug/tracing//kprobe_events write=0
> > > Opening /sys/kernel/debug/tracing//uprobe_events write=0
> > > Parsing probe_events: p:probe_libc/malloc_get_state /usr/lib64/libc-2.25.so:0x00000000dd38eca7
> > > Group:probe_libc Event:malloc_get_state probe:p
> > > try to find information at dd38eca7 in /usr/lib64/libc-2.25.so
> > > Open Debuginfo file: /usr/lib/debug/usr/lib64/libc-2.25.so.debug
> > > Failed to find debug information for address dd38eca7
> > > Failed to find corresponding probes from debuginfo.
> > > symsrc__init: build id mismatch for /usr/lib/debug/usr/lib64/libc-2.25.so.debug.
> > > Failed to find probe point from both of dwarf and map.
> > >   probe_libc:malloc_get_state (on 0xdd38eca7 in /usr/lib64/libc-2.25.so)
> > > [root@jouet perf]#
> > 
> > Ah, I got it. So symsrc__init checks debugfile to get symbols,
> > but failed.
> > 
> > > 
> > > Ok, so build-id mismatch, lets see:
> > > 
> > > [root@jouet perf]# rpm -q glibc glibc-debuginfo
> > > glibc-2.25-10.fc26.x86_64
> > > glibc-2.25-10.fc26.i686
> > > glibc-debuginfo-2.25-12.fc26.x86_64
> > > [root@jouet perf]#
> > > 
> > > Ok, the debuginfo file is newer than the glibc installed, updating glibc
> > > now...
> > > 
> > > We could have a more informative message in this case, right? I.e.
> > > something like:
> > > 
> > > [root@jouet perf]# perf probe -l
> > > There was a build-id mismatch while trying to resolve 0xdd38eca7, please
> > > check your system's debuginfo files for mismatches, e.g. check the
> > > versions for glibc and glibc-debuginfo.
> > >   probe_libc:malloc_get_state (on 0xdd38eca7 in /usr/lib64/libc-2.25.so)
> > 
> > OK, I'll try to check how debuginfo is searched in such environment.
> 
> So, tools/perf/util/symbol.c, function dso__load(), it will have this
> loop:
> 
> 
>         /*
>          * Read the build id if possible. This is required for
>          * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work
>          */
>         if (!dso->has_build_id && is_regular_file(dso->long_name)) {
>             __symbol__join_symfs(name, PATH_MAX, dso->long_name);
>             if (filename__read_build_id(name, build_id, BUILD_ID_SIZE) > 0)
>                 dso__set_build_id(dso, build_id);
>         }
> 
>         /*
>          * Iterate over candidate debug images.
>          * Keep track of "interesting" ones (those which have a symtab, dynsym,
>          * and/or opd section) for processing.
>          */
>         for (i = 0; i < DSO_BINARY_TYPE__SYMTAB_CNT; i++) {
> 
>                 if (dso__read_binary_type_filename(dso, symtab_type, root_dir, name, PATH_MAX))
> 
> 
> -------------------
> 
> So the glibc file _has_ a build id, it reads it and then will try to
> find a file that has that build id, that 'name' variable will have
> the file being tried, which may be, for instance, at:
> 
> [acme@jouet ~]$ perf buildid-list -i /lib64/libc-2.25.so 
> 7a4787e7c1263dc25461a7b2f2abd2acaa186102
> [acme@jouet ~]$ ls -la /usr/lib/debug/.build-id/7a/4787e7c1263dc25461a7b2f2abd2acaa186102
> lrwxrwxrwx. 1 root root 33 Oct 11 09:49 /usr/lib/debug/.build-id/7a/4787e7c1263dc25461a7b2f2abd2acaa186102 -> ../../../../../lib64/libc-2.25.so
> [acme@jouet ~]$ 
> 
> etc.
> 
> So perhaps we can have a routine that does just that loop and prints the
> files it finds with the debuginfo they have to help tell which files
> where considered?

Hmm, as far as I can see, this occured in debuginfo__new(), 

struct debuginfo *debuginfo__new(const char *path)
{
        enum dso_binary_type *type;
        char buf[PATH_MAX], nil = '\0';
        struct dso *dso;
        struct debuginfo *dinfo = NULL;

        /* Try to open distro debuginfo files */
        dso = dso__new(path);
        if (!dso)
                goto out;

        for (type = distro_dwarf_types;
             !dinfo && *type != DSO_BINARY_TYPE__NOT_FOUND;
             type++) {
                if (dso__read_binary_type_filename(dso, *type, &nil,
                                                   buf, PATH_MAX) < 0)
                        continue;
                dinfo = __debuginfo__new(buf);
        }
        dso__put(dso);

out:
        /* if failed to open all distro debuginfo, open given binary */
        return dinfo ? : __debuginfo__new(path);
}

And dso__read_binary_type_filename() makes a debuginfo path
from target path but doesn't check build-id. So,
(I still can not reproduce your situation but) I guess,
dso__read_binary_type_filename() returns some path, but
__debuginfo__new() just failed to open it.
Or, __debuginfo_new() opened it but since its buildid is
different, it really failed to find any lines on given address.

> 
> But perhaps the message I suggested may be good enough?

Yeah, but this means we need to check the buildid of both
binaries.

Thank you,

> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
