% Game tiles

% Empty tile
translate(0, _, 1):- write('   ').
translate(0, _, 2):- write('   ').
translate(0, _, 3):- write('   ').

% Starting and finish markers
translate(1, _, 1):- write(' - ').
translate(1, 0, 2):- write('| |').
translate(1, 1, 2):- write('|+|').
translate(1, 2, 2):- write('|x|').
translate(1, _, 3):- write(' - ').
translate(2, _, 1):- write(' - ').
translate(2, 0, 2):- write('|#|').
translate(2, 1, 2):- write('|+|').
translate(2, 2, 2):- write('|x|').
translate(2, _, 3):- write(' - ').
translate(3, _, 1):- write('   ').
translate(3, 0, 2):- write('( )').
translate(3, 1, 2):- write('(+)').
translate(3, 2, 2):- write('(x)').
translate(3, _, 3):- write('   ').
translate(4, _, 1):- write('   ').
translate(4, 0, 2):- write('(#)').
translate(4, 1, 2):- write('(+)').
translate(4, 2, 2):- write('(x)').
translate(4, _, 3):- write('   ').

% Directional tiles
translate(5, _, 1):- write(' | ').
translate(5, 0, 2):- write(' o ').
translate(5, 1, 2):- write(' + ').
translate(5, 2, 2):- write(' x ').
translate(5, _, 3):- write('/| ').
translate(6, _, 1):- write('  /').
translate(6, 0, 2):- write('-o-').
translate(6, 1, 2):- write('-+-').
translate(6, 2, 2):- write('-x-').
translate(6, _, 3):- write('   ').
translate(7, _, 1):- write(' | ').
translate(7, 0, 2):- write('-o-').
translate(7, 1, 2):- write('-+-').
translate(7, 2, 2):- write('-x-').
translate(7, _, 3):- write('   ').
translate(8, _, 1):- write('   ').
translate(8, 0, 2):- write(' o-').
translate(8, 1, 2):- write(' +-').
translate(8, 2, 2):- write(' x-').
translate(8, _, 3):- write('/ \\').
translate(9, _, 1):- write(' | ').
translate(9, 0, 2):- write('-o ').
translate(9, 1, 2):- write('-+ ').
translate(9, 2, 2):- write('-x ').
translate(9, _, 3):- write('/  ').
translate(10, _, 1):- write(' | ').
translate(10, 0, 2):- write(' o-').
translate(10, 1, 2):- write(' +-').
translate(10, 2, 2):- write(' x-').
translate(10, _, 3):- write('  \\').
translate(11, _, 1):- write('   ').
translate(11, 0, 2):- write('-o ').
translate(11, 1, 2):- write('-+ ').
translate(11, 2, 2):- write('-x ').
translate(11, _, 3):- write(' |\\').
translate(12, _, 1):- write('  /').
translate(12, 0, 2):- write(' o ').
translate(12, 1, 2):- write(' + ').
translate(12, 2, 2):- write(' x ').
translate(12, _, 3):- write('/ \\').
translate(13, _, 1):- write('\\|/').
translate(13, 0, 2):- write(' o ').
translate(13, 1, 2):- write(' + ').
translate(13, 2, 2):- write(' x ').
translate(13, _, 3):- write('   ').
translate(14, _, 1):- write('  /').
translate(14, 0, 2):- write(' o ').
translate(14, 1, 2):- write(' + ').
translate(14, 2, 2):- write(' x ').
translate(14, _, 3):- write(' |\\').
translate(15, _, 1):- write('   ').
translate(15, 0, 2):- write(' o ').
translate(15, 1, 2):- write(' + ').
translate(15, 2, 2):- write(' x ').
translate(15, _, 3):- write('/|\\').
translate(16, _, 1):- write('\\| ').
translate(16, 0, 2):- write('-o ').
translate(16, 1, 2):- write('-+ ').
translate(16, 2, 2):- write('-x ').
translate(16, _, 3):- write('   ').
translate(17, _, 1):- write('\\  ').
translate(17, 0, 2):- write(' o ').
translate(17, 1, 2):- write(' + ').
translate(17, 2, 2):- write(' x ').
translate(17, _, 3):- write(' |\\').
translate(18, _, 1):- write('\\ /').
translate(18, 0, 2):- write(' o ').
translate(18, 1, 2):- write(' + ').
translate(18, 2, 2):- write(' x ').
translate(18, _, 3):- write(' | ').
translate(19, _, 1):- write(' | ').
translate(19, 0, 2):- write(' o-').
translate(19, 1, 2):- write(' +-').
translate(19, 2, 2):- write(' x-').
translate(19, _, 3):- write(' | ').
translate(20, _, 1):- write('\\| ').
translate(20, 0, 2):- write(' o-').
translate(20, 1, 2):- write(' +-').
translate(20, 2, 2):- write(' x-').
translate(20, _, 3):- write('   ').
translate(21, _, 1):- write('\\ /').
translate(21, 0, 2):- write('-o ').
translate(21, 1, 2):- write('-+ ').
translate(21, 2, 2):- write('-x ').
translate(21, _, 3):- write('   ').
translate(22, _, 1):- write('\\  ').
translate(22, 0, 2):- write('-o ').
translate(22, 1, 2):- write('-+ ').
translate(22, 2, 2):- write('-x ').
translate(22, _, 3):- write('/  ').
translate(23, _, 1):- write('\\| ').
translate(23, 0, 2):- write(' o ').
translate(23, 1, 2):- write(' + ').
translate(23, 2, 2):- write(' x ').
translate(23, _, 3):- write('/  ').
translate(24, _, 1):- write(' | ').
translate(24, 0, 2):- write(' o-').
translate(24, 1, 2):- write(' +-').
translate(24, 2, 2):- write(' x-').
translate(24, _, 3):- write('/  ').
translate(25, _, 1):- write('   ').
translate(25, 0, 2):- write('-o-').
translate(25, 1, 2):- write('-+-').
translate(25, 2, 2):- write('-x-').
translate(25, _, 3):- write('  \\').
translate(26, _, 1):- write('  /').
translate(26, 0, 2):- write('-o ').
translate(26, 1, 2):- write('-+ ').
translate(26, 2, 2):- write('-x ').
translate(26, _, 3):- write('/  ').
translate(27, _, 1):- write('\\  ').
translate(27, 0, 2):- write(' o-').
translate(27, 1, 2):- write(' +-').
translate(27, 2, 2):- write(' x-').
translate(27, _, 3):- write('/ \\').
translate(28, _, 1):- write('  /').
translate(28, 0, 2):- write(' o-').
translate(28, 1, 2):- write(' +-').
translate(28, 2, 2):- write(' x-').
translate(28, _, 3):- write('  \\').
translate(29, _, 1):- write('   ').
translate(29, 0, 2):- write(' o-').
translate(29, 1, 2):- write(' +-').
translate(29, 2, 2):- write(' x-').
translate(29, _, 3):- write(' |\\').
translate(30, _, 1):- write(' | ').
translate(30, 0, 2):- write(' o ').
translate(30, 1, 2):- write(' + ').
translate(30, 2, 2):- write(' x ').
translate(30, _, 3):- write('/ \\').
translate(31, _, 1):- write('   ').
translate(31, 0, 2):- write('-o-').
translate(31, 1, 2):- write('-+-').
translate(31, 2, 2):- write('-x-').
translate(31, _, 3):- write(' | ').
translate(32, _, 1):- write('  /').
translate(32, 0, 2):- write(' o-').
translate(32, 1, 2):- write(' +-').
translate(32, 2, 2):- write(' x-').
translate(32, _, 3):- write('/  ').
translate(33, _, 1):- write('   ').
translate(33, 0, 2):- write('-o ').
translate(33, 1, 2):- write('-+ ').
translate(33, 2, 2):- write('-x ').
translate(33, _, 3):- write('/ \\').
translate(34, _, 1):- write(' |/').
translate(34, 0, 2):- write(' o ').
translate(34, 1, 2):- write(' + ').
translate(34, 2, 2):- write(' x ').
translate(34, _, 3):- write('  \\').
translate(35, _, 1):- write('\\  ').
translate(35, 0, 2):- write('-o ').
translate(35, 1, 2):- write('-+ ').
translate(35, 2, 2):- write('-x ').
translate(35, _, 3):- write(' | ').
translate(36, _, 1):- write('\\  ').
translate(36, 0, 2):- write(' o-').
translate(36, 1, 2):- write(' +-').
translate(36, 2, 2):- write(' x-').
translate(36, _, 3):- write('/  ').
translate(37, _, 1):- write('  /').
translate(37, 0, 2):- write('-o ').
translate(37, 1, 2):- write('-+ ').
translate(37, 2, 2):- write('-x ').
translate(37, _, 3):- write('  \\').
translate(38, _, 1):- write('   ').
translate(38, 0, 2):- write('-o-').
translate(38, 1, 2):- write('-+-').
translate(38, 2, 2):- write('-x-').
translate(38, _, 3):- write('/  ').
translate(39, _, 1):- write('\\| ').
translate(39, 0, 2):- write(' o ').
translate(39, 1, 2):- write(' + ').
translate(39, 2, 2):- write(' x ').
translate(39, _, 3):- write(' | ').
translate(40, _, 1):- write('   ').
translate(40, 0, 2):- write('-o-').
translate(40, 1, 2):- write('-+-').
translate(40, 2, 2):- write('-x-').
translate(40, _, 3):- write(' | ').
translate(41, _, 1):- write(' | ').
translate(41, 0, 2):- write('-o ').
translate(41, 1, 2):- write('-+ ').
translate(41, 2, 2):- write('-x ').
translate(41, _, 3):- write('  \\').
translate(42, _, 1):- write('\\  ').
translate(42, 0, 2):- write(' o ').
translate(42, 1, 2):- write(' + ').
translate(42, 2, 2):- write(' x ').
translate(42, _, 3):- write('/| ').
translate(43, _, 1):- write('\\| ').
translate(43, 0, 2):- write(' o ').
translate(43, 1, 2):- write(' + ').
translate(43, 2, 2):- write(' x ').
translate(43, _, 3):- write('  \\').
translate(44, _, 1):- write(' |/').
translate(44, 0, 2):- write(' o ').
translate(44, 1, 2):- write(' + ').
translate(44, 2, 2):- write(' x ').
translate(44, _, 3):- write(' | ').
translate(45, _, 1):- write('\\  ').
translate(45, 0, 2):- write(' o-').
translate(45, 1, 2):- write(' +-').
translate(45, 2, 2):- write(' x-').
translate(45, _, 3):- write(' | ').
translate(46, _, 1):- write('\\  ').
translate(46, 0, 2):- write('-o-').
translate(46, 1, 2):- write('-+-').
translate(46, 2, 2):- write('-x-').
translate(46, _, 3):- write('   ').
translate(47, _, 1):- write('\\  ').
translate(47, 0, 2):- write('-o ').
translate(47, 1, 2):- write('-+ ').
translate(47, 2, 2):- write('-x ').
translate(47, _, 3):- write('  \\').
translate(48, _, 1):- write(' | ').
translate(48, 0, 2):- write(' o ').
translate(48, 1, 2):- write(' + ').
translate(48, 2, 2):- write(' x ').
translate(48, _, 3):- write(' |\\').
translate(49, _, 1):- write('  /').
translate(49, 0, 2):- write(' o ').
translate(49, 1, 2):- write(' + ').
translate(49, 2, 2):- write(' x ').
translate(49, _, 3):- write('/| ').
translate(50, _, 1):- write('  /').
translate(50, 0, 2):- write(' o-').
translate(50, 1, 2):- write(' +-').
translate(50, 2, 2):- write(' x-').
translate(50, _, 3):- write(' | ').
translate(51, 0, 1):- write('\\  ').
translate(51, 0, 2):- write(' o-').
translate(51, 1, 2):- write(' +-').
translate(51, 2, 2):- write(' x-').
translate(51, _, 3):- write('  \\').
translate(52, _, 1):- write(' |/').
translate(52, 0, 2):- write('-o ').
translate(52, 1, 2):- write('-+ ').
translate(52, 2, 2):- write('-x ').
translate(52, _, 3):- write('   ').
translate(53, _, 1):- write(' |/').
translate(53, 0, 2):- write(' o-').
translate(53, 1, 2):- write(' +-').
translate(53, 2, 2):- write(' x-').
translate(53, _, 3):- write('   ').
translate(54, _, 1):- write('   ').
translate(54, 0, 2):- write(' o-').
translate(54, 1, 2):- write(' +-').
translate(54, 2, 2):- write(' x-').
translate(54, _, 3):- write('/| ').
translate(55, _, 1):- write('\\ /').
translate(55, 0, 2):- write(' o ').
translate(55, 1, 2):- write(' + ').
translate(55, 2, 2):- write(' x ').
translate(55, _, 3):- write('  \\').
translate(56, _, 1):- write('\\ /').
translate(56, 0, 2):- write(' o ').
translate(56, 1, 2):- write(' + ').
translate(56, 2, 2):- write(' x ').
translate(56, _, 3):- write('/  ').
translate(57, _, 1):- write(' |/').
translate(57, 0, 2):- write(' o ').
translate(57, 1, 2):- write(' + ').
translate(57, 2, 2):- write(' x ').
translate(57, _, 3):- write('/  ').
translate(58, _, 1):- write('   ').
translate(58, 0, 2):- write('-o ').
translate(58, 1, 2):- write('-+ ').
translate(58, 2, 2):- write('-x ').
translate(58, _, 3):- write('/| ').
translate(59, _, 1):- write('  /').
translate(59, 0, 2):- write('-o ').
translate(59, 1, 2):- write('-+ ').
translate(59, 2, 2):- write('-x ').
translate(59, _, 3):- write(' | ').
translate(60, _, 1):- write('\\ /').
translate(60, 0, 2):- write(' o-').
translate(60, 1, 2):- write(' +-').
translate(60, 2, 2):- write(' x-').
translate(60, _, 3):- write('   ').