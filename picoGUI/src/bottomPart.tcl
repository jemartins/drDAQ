#=============================================
#
#	bottomPart.tcl
#
#=============================================

#########################################################################
#
#    Copyright (C) 2006 DrDAQ Application Project.
#
#   This software is in the public domain.
#    Permission to use, copy, modify, and distribute this software and its
#    documentation for any purpose and without fee is hereby granted,
#    without any conditions or restrictions.
#    This software is provided "as is" without express or implied warranty.
#
#    If you discover a bug or add an enhancement here's how to reach us:
#
#        https://sourceforge.net/projects/drdaq
#
##########################################################################
##########################################################################
# Revision history:
#
# $Log: bottomPart.tcl,v $
# Revision 1.9  2006/06/22 14:03:01  jemartins
# added myID
#
# Revision 1.8  2006/06/15 13:14:57  jemartins
# removed ioaName
#
# Revision 1.7  2006/06/14 18:38:31  jemartins
# added ioaName
#
# Revision 1.6  2006/05/15 17:48:50  jemartins
# added Copyright
#
# Revision 1.5  2006/05/03 01:55:22  jemartins
# added -f entry
#
# Revision 1.5  2006/05/02 03:08:54  jemartins
# comment out name_atach() entry
#
# Revision 1.4  2006/05/02 00:40:49  jemartins
# *** empty log message ***
#
# Revision 1.3  2006/05/02 00:00:31  jemartins
# added global Delta_T and ncont
#
# Revision 1.2  2006/05/01 23:37:13  jemartins
# added global vars entry
#
# Revision 1.1  2006/05/01 20:31:01  jemartins
# test guivTcl
#
# Revision 1.3  2006/03/23 22:32:10  bobfcsoft
# code cleanup
#
# Revision 1.2  2006/03/08 19:20:48  bobfcsoft
# code cleanup
#
# Revision 1.1.1.1  2006/03/07 21:29:31  bobfcsoft
# startup
#
#=============================================
#================================================
#	main - entry point
#================================================

set fn main
set logMask 0xff
set loggerName ""
set picoMgrName ""
set myName ""
set myID 0

set state flag
foreach arg $argv {
	switch -- $state {
		flag {
			switch -glob -- $arg {
				-N	{ set state name }
				-p	{ set state pico }
				-f	{ set state fifo }
				-I	{ set state id }
				-m	{ set state mask }
				-l	{ set state logger }
				default { puts stdout "error unknown flag $arg"
					exit
				}
			}
		}
		
		name {
			set myName $arg
			set state flag
		}

		pico {
			set picoMgrName $arg
			set state flag
		}

		fifo {
			set FIFO_PATH $arg
			set state flag
		}

		id {
			set myID $arg
			set state flag
		}
		
		mask {
			set logMask $arg
			set state flag
		}

		logger {
			set loggerName $arg
			set state flag
		}
	};# end switch state
};# end foreach

set myslot [name_attach $myName 2048]
catch {puts stdout [format "myName=<%s> myslot=%d" $myName $myslot]}

if { $loggerName == "" } {
	set logger -1
} else {
	set logger [name_locate "LOGGER"]
}

#catch {puts stdout [format "loggerName=<%s> id=%d" $loggerName $logger]}

#catch {puts stdout [format "logMask=%X" $logMask]}

set myFifo [ format "%s/%s" $FIFO_PATH $myslot ]
set recvid [ open $myFifo {RDWR}]
#catch {puts stdout [ format "myFifo=%s fd=%d" $myFifo $recvid]}
#catch {puts stdout "dropping into wait forever loop"}

logit $logger $this $fn $MASK_MISC $logMask [format "myName=<%s> myslot=%s" $myName $myslot]
logit $logger $this $fn $MASK_MISC $logMask [format "loggerName=<%s> id=%d" $loggerName $logger]
logit $logger $this $fn $MASK_MISC $logMask [format "logMask=%X" $logMask]
logit $logger $this $fn $MASK_MISC $logMask [format "myFifo=<%s> fd=<%s>" $myFifo $recvid]

#renderMain

if { $picoMgrName == "" } {
	set picoMgrID -1
} else {
	set picoMgrID [name_locate $picoMgrName]
}

fileevent $recvid readable doReceive
#vwait forever

#name_detach

puts stdout {done}

#exit
#
#================ end bottomPart =======================
